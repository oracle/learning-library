import oci
import sys
import base64
import time

# ==========================================================
# This file provides an example of basic streaming usage
# * - List streams
# * - Get a Stream
# * - Create a Stream
# * - Delete a Stream
# * - Publish to a Stream
# * - Consume from a stream partition using cursor
# * - Consume from a stream using a group cursor
# Documentation : https://docs.cloud.oracle.com/iaas/Content/Streaming/Concepts/streamingoverview.htm

# Usage : python stream_example.py <compartment id>

STREAM_NAME = "SdkExampleStream"
PARTITIONS = 1


def publish_example_messages(client, stream_id):
    # Build up a PutMessagesDetails and publish some messages to the stream
    message_list = []
    for i in range(100):
        key = "key" + str(i)
        value = "value" + str(i)
        encoded_key = base64.b64encode(key)
        encoded_value = base64.b64encode(value)
        message_list.append(oci.streaming.models.PutMessagesDetailsEntry(key=encoded_key, value=encoded_value))

    print ("Publishing {} messages to the stream {} ".format(len(message_list), stream_id))
    messages = oci.streaming.models.PutMessagesDetails(messages=message_list)
    put_message_result = client.put_messages(stream_id, messages)

    # The put_message_result can contain some useful metadata for handling failures
    for entry in put_message_result.data.entries:
        if entry.error:
            print ("Error ({}) : {}".format(entry.error, entry.error_message))
        else:
            print ("Published message to partition {} , offset {}".format(entry.partition, entry.offset))


def get_or_create_stream(client, compartment_id, stream_name, partition, sac_composite):

    list_streams = client.list_streams(compartment_id, name=stream_name,
                                       lifecycle_state=oci.streaming.models.StreamSummary.LIFECYCLE_STATE_ACTIVE)
    if list_streams.data:
        # If we find an active stream with the correct name, we'll use it.
        print ("An active stream {} has been found".format(stream_name))
        sid = list_streams.data[0].id
        return get_stream(sac_composite.client, sid)

    print (" No Active stream  {} has been found; Creating it now. ".format(stream_name))
    print (" Creating stream {} with {} partitions.".format(stream_name, partition))

    # Create stream_details object that need to be passed while creating stream.
    stream_details = oci.streaming.models.CreateStreamDetails(name=stream_name, partitions=partition,
                                                              compartment_id=compartment, retention_in_hours=24)

    # Since stream creation is asynchronous; we need to wait for the stream to become active.
    response = sac_composite.create_stream_and_wait_for_state(
        stream_details, wait_for_states=[oci.streaming.models.StreamSummary.LIFECYCLE_STATE_ACTIVE])
    return response


def get_stream(admin_client, stream_id):
    return admin_client.get_stream(stream_id)


def delete_stream(client, stream_id):
    print (" Deleting Stream {}".format(stream_id))
    # Stream deletion is an asynchronous operation, give it some time to complete.
    client.delete_stream_and_wait_for_state(stream_id, oci.streaming.models.StreamSummary.LIFECYCLE_STATE_DELETED)


def get_cursor_by_partition(client, stream_id, partition):
    print("Creating a cursor for partition {}".format(partition))
    cursor_details = oci.streaming.models.CreateCursorDetails(
        partition=partition,
        type=oci.streaming.models.CreateCursorDetails.TYPE_TRIM_HORIZON)
    response = client.create_cursor(stream_id, cursor_details)
    cursor = response.data.value
    return cursor


def simple_message_loop(client, stream_id, initial_cursor):
    cursor = initial_cursor
    while True:
        get_response = client.get_messages(stream_id, cursor, limit=10)
        # No messages to process. return.
        if not get_response.data:
            return

        # Process the messages
        print(" Read {} messages".format(len(get_response.data)))
        for message in get_response.data:
            print("{}: {}".format(base64.b64decode(message.key), base64.b64decode(message.value)))

        # get_messages is a throttled method; clients should retrieve sufficiently large message
        # batches, as to avoid too many http requests.
        time.sleep(1)
        # use the next-cursor for iteration
        cursor = get_response.headers["opc-next-cursor"]


def get_cursor_by_group(sc, sid, group_name, instance_name):
    print(" Creating a cursor for group {}, instance {}".format(group_name, instance_name))
    cursor_details = oci.streaming.models.CreateGroupCursorDetails(group_name=group_name, instance_name=instance_name,
                                                                   type=oci.streaming.models.
                                                                   CreateGroupCursorDetails.TYPE_TRIM_HORIZON,
                                                                   commit_on_get=True)
    response = sc.create_group_cursor(sid, cursor_details)
    return response.data.value


# Load the default configuration
config = oci.config.from_file()

# Create a StreamAdminClientCompositeOperations for composite operations.
stream_admin_client = oci.streaming.StreamAdminClient(config)
stream_admin_client_composite = oci.streaming.StreamAdminClientCompositeOperations(stream_admin_client)

if len(sys.argv) != 2:
    raise RuntimeError('This example expects an ocid for the compartment in which streams should be created.')

compartment = sys.argv[1]

# We  will reuse a stream if its already created.
# This will utilize list_streams() to determine if a stream exists and return it, or create a new one.
stream = get_or_create_stream(stream_admin_client, compartment, STREAM_NAME,
                              PARTITIONS, stream_admin_client_composite).data

print (" Created Stream {} with id : {}".format(stream.name, stream.id))

#answer = None
#print ("Switch to OCI Console window and verify Stream named 'SdkExampleStream' was created. Enter 'y' once verified")
print("\n")
print ("**Switch to OCI Console window and verify Stream named 'SdkExampleStream' was created. Click on the stream name to see the details, also verify there are no messages publsihed on this stream**")
print("\n")
raw_input("Press Enter to continue:  ") 
print ("\n")
#eStreams are assigned a specific endpoint url based on where they are provisioned.
# Create a stream client using the provided message endpoint.
stream_client = oci.streaming.StreamClient(config, service_endpoint=stream.messages_endpoint)
s_id = stream.id

print("\n **Starting a simple message loop. This will publish 100 message to the newly created stream.**")
print("\n")
# Publish some messages to the stream
raw_input ("Press Enter to continue:  ")
print ("ok")

publish_example_messages(stream_client, s_id)

# Use a cursor for getting messages; each get_messages call will return a next-cursor for iteration.
# There are a couple kinds of cursors.
# A cursor can be created at a given partition/offset.
# This gives explicit offset management control to the consumer.

print("\n **Switch to OCI Console window and verify messages were published. You can click 'Refresh' under Recent Messages in Stream details page**")
print("\n")
# Publish some messages to the stream
raw_input ("Press Enter to continue:  ")
print ("ok")

print("\n **We will now create a parition cursor and start consuming these messages. Messages will be consumed by multiple groups**")
print("\n")
# Publish some messages to the stream
raw_input ("Press Enter to continue:  ")
print ("ok")

#print("Starting a simple message loop with a partition cursor")
partition_cursor = get_cursor_by_partition(stream_client, s_id, partition="0")
simple_message_loop(stream_client, s_id, partition_cursor)

# A cursor can be created as part of a consumer group.
# Committed offsets are managed for the group, and partitions
# are dynamically balanced amongst consumers in the group.
group_cursor = get_cursor_by_group(stream_client, s_id, "example-group", "example-instance-1")
simple_message_loop(stream_client, s_id, group_cursor)

# Cleanup; remember to delete streams which are not in use.
print("\n **We will now delete the stream**")
print("\n")
raw_input ("Press Enter to continue:  ")
print ("ok")

delete_stream(stream_admin_client_composite, s_id)
print("\n\n **** Stream Deleted ****\n")
