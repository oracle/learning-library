# coding: utf-8
# Copyright (c) 2016, 2019, Oracle and/or its affiliates. All rights reserved.

import oci  # noqa: F401
from oci.util import WAIT_RESOURCE_NOT_FOUND  # noqa: F401


class StreamAdminClientCompositeOperations(object):
    """
    This class provides a wrapper around :py:class:`~oci.streaming.StreamAdminClient` and offers convenience methods
    for operations that would otherwise need to be chained together. For example, instead of performing an action
    on a resource (e.g. launching an instance, creating a load balancer) and then using a waiter to wait for the resource
    to enter a given state, you can call a single method in this class to accomplish the same functionality
    """

    def __init__(self, client, **kwargs):
        """
        Creates a new StreamAdminClientCompositeOperations object

        :param StreamAdminClient client:
            The service client which will be wrapped by this object
        """
        self.client = client

    def create_stream_and_wait_for_state(self, create_stream_details, wait_for_states=[], operation_kwargs={}, waiter_kwargs={}):
        """
        Calls :py:func:`~oci.streaming.StreamAdminClient.create_stream` and waits for the :py:class:`~oci.streaming.models.Stream` acted upon
        to enter the given state(s).

        :param CreateStreamDetails create_stream_details: (required)
            The stream to create.

        :param list[str] wait_for_states:
            An array of states to wait on. These should be valid values for :py:attr:`~oci.streaming.models.Stream.lifecycle_state`

        :param dict operation_kwargs:
            A dictionary of keyword arguments to pass to :py:func:`~oci.streaming.StreamAdminClient.create_stream`

        :param dict waiter_kwargs:
            A dictionary of keyword arguments to pass to the :py:func:`oci.wait_until` function. For example, you could pass ``max_interval_seconds`` or ``max_interval_seconds``
            as dictionary keys to modify how long the waiter function will wait between retries and the maximum amount of time it will wait
        """
        operation_result = self.client.create_stream(create_stream_details, **operation_kwargs)
        if not wait_for_states:
           return operation_result
        lowered_wait_for_states = [w.lower() for w in wait_for_states]
        wait_for_resource_id = operation_result.data.id

        try:
            waiter_result = oci.wait_until(
                self.client,
                self.client.get_stream(wait_for_resource_id),
                evaluate_response=lambda r: getattr(r.data, 'lifecycle_state') and getattr(r.data, 'lifecycle_state').lower() in lowered_wait_for_states,
                **waiter_kwargs
            )
            result_to_return = waiter_result

            return result_to_return
        except Exception as e:
            raise oci.exceptions.CompositeOperationError(partial_results=[operation_result], cause=e)

    def delete_stream_and_wait_for_state(self, stream_id, wait_for_states=[], operation_kwargs={}, waiter_kwargs={}):
        """
        Calls :py:func:`~oci.streaming.StreamAdminClient.delete_stream` and waits for the :py:class:`~oci.streaming.models.Stream` acted upon
        to enter the given state(s).

        :param str stream_id: (required)
            The OCID of the stream to delete.

        :param list[str] wait_for_states:
            An array of states to wait on. These should be valid values for :py:attr:`~oci.streaming.models.Stream.lifecycle_state`

        :param dict operation_kwargs:
            A dictionary of keyword arguments to pass to :py:func:`~oci.streaming.StreamAdminClient.delete_stream`

        :param dict waiter_kwargs:
            A dictionary of keyword arguments to pass to the :py:func:`oci.wait_until` function. For example, you could pass ``max_interval_seconds`` or ``max_interval_seconds``
            as dictionary keys to modify how long the waiter function will wait between retries and the maximum amount of time it will wait
        """
        initial_get_result = self.client.get_stream(stream_id)
        operation_result = None
        operation_result = self.client.delete_stream(stream_id, **operation_kwargs)

#        try:
#            operation_result = self.client.delete_stream(stream_id, **operation_kwargs)
#        except oci.exceptions.ServiceError as e:
#           if e.status == 404:
#                return WAIT_RESOURCE_NOT_FOUND
#            else:
#                raise e

#        if not wait_for_states:
#            return operation_result

#     lowered_wait_for_states = [w.lower() for w in wait_for_states]
#
#        try:
#            waiter_result = oci.wait_until(
#                self.client,
#                initial_get_result,
#                evaluate_response=lambda r: getattr(r.data, 'lifecycle_state') and getattr(r.data, 'lifecycle_state').lower() in lowered_wait_for_states,
#                succeed_on_not_found=True,
#                **waiter_kwargs
#            )
#            result_to_return = waiter_result
#
#           return result_to_return
#        except Exception as e:
#           raise oci.exceptions.CompositeOperationError(partial_results=[operation_result], cause=e)

    def update_stream_and_wait_for_state(self, stream_id, update_stream_details, wait_for_states=[], operation_kwargs={}, waiter_kwargs={}):
        """
        Calls :py:func:`~oci.streaming.StreamAdminClient.update_stream` and waits for the :py:class:`~oci.streaming.models.Stream` acted upon
        to enter the given state(s).

        :param str stream_id: (required)
            The OCID of the stream to update.

        :param UpdateStreamDetails update_stream_details: (required)
            The stream is updated with the tags provided.

        :param list[str] wait_for_states:
            An array of states to wait on. These should be valid values for :py:attr:`~oci.streaming.models.Stream.lifecycle_state`

        :param dict operation_kwargs:
            A dictionary of keyword arguments to pass to :py:func:`~oci.streaming.StreamAdminClient.update_stream`

        :param dict waiter_kwargs:
            A dictionary of keyword arguments to pass to the :py:func:`oci.wait_until` function. For example, you could pass ``max_interval_seconds`` or ``max_interval_seconds``
            as dictionary keys to modify how long the waiter function will wait between retries and the maximum amount of time it will wait
        """
        operation_result = self.client.update_stream(stream_id, update_stream_details, **operation_kwargs)
        if not wait_for_states:
            return operation_result

        lowered_wait_for_states = [w.lower() for w in wait_for_states]
        wait_for_resource_id = operation_result.data.id

        try:
            waiter_result = oci.wait_until(
                self.client,
                self.client.get_stream(wait_for_resource_id),
                evaluate_response=lambda r: getattr(r.data, 'lifecycle_state') and getattr(r.data, 'lifecycle_state').lower() in lowered_wait_for_states,
                **waiter_kwargs
            )
            result_to_return = waiter_result

            return result_to_return
        except Exception as e:
            raise oci.exceptions.CompositeOperationError(partial_results=[operation_result], cause=e)
