# Lab 10: Pattern Matching for instanceof

## Overview

In this 10-minutes lab, you will get some hands-on expereince with the *pattern Matching for instanceof* feature previewed in JDK 15. This feature enhances the Java programming language with pattern matching for the instanceof operator. Pattern matching allows common logic in a program, namely the conditional extraction of components from objects, to be expressed more concisely and safely.


## Using 'pattern matching for instanceof'

💡 Make sure to checkout the lab10 branch as it introduces 2 new classes to the project: `AgendaRepository.java` and `AgendaService.java`

```
git checkout -f lab10
```

Chek those 2 new classes. `AgendaService.java` introduces a new "/sessions" endpoint that returns the details of the sessions. The sessions are stored in `AgendaRepository.java` using a simple `List<Session>`. The `Session` type has been introduced in Lab 8, it is a sealed abstract class that can only be extended by a given set of classes (check Lab 8 for details).

Build and test the application, `curl {public_ip}:8080/sessions`

![](./images/lab10-1.png " ")



Let's pretend that the displyed details vary based on the session type.

Add the following `getSessionDetails` method to the "AgendaServoce".

`nano src/main/java/conference/AgendaService.java`

```
private void getSessionDetails(final ServerRequest request, final ServerResponse response) {
   LOGGER.fine("getSessionDetails");

   var sessionId = request.path().param("sessionId").trim();

   Optional<Session> session = sessions.getBySessionId(sessionId);

   if (session.isPresent()) {

       record SessionDetail(String title, String speaker, String location, String type) {
           JsonObject toJson() {
              JsonObject payload = Json.createObjectBuilder()
                      .add("session", title)
                      .add("speaker", speaker)
                      .add("virtual_room", location)
                      .add("type", type)
                      .build();
               return payload;
           }
       }

       var speakerDetail = "speaker TBC!";
       var s = session.get();

       if (s instanceof Keynote) {

           Keynote k = (Keynote) s;

           var ks = speakers.getById(k.getKeynoteSpeaker());
           if (ks.isPresent()) {
               var spk = ks.get();
               speakerDetail = spk.firstName() + " " + spk.lastName() + " (" + spk.company() + ")";
           } else speakerDetail = "Keynote speaker to be announced!";

           var keynote = new SessionDetail("Keynote: " + k.getTitle(), speakerDetail, "Virtual Keynote hall", "General session");
           response.send(keynote.toJson());

       } else if (s instanceof Lecture) {

           Lecture l = (Lecture) s;

           var speaker = speakers.getById(l.getSpeaker());
           if (speaker.isPresent()) {
               var spk = speaker.get();
               speakerDetail = spk.firstName() + " " + spk.lastName() + " (" + spk.company() + ")";
           }

           var lecture = new SessionDetail(l.getTitle(), speakerDetail, String.valueOf(l.getVirtualRoom()), "Conference session");
           response.send(lecture.toJson());

       } else if (s instanceof Lab) {

           Lab l = (Lab) s;

           var speaker = speakers.getById(l.getSpeaker());
           if (speaker.isPresent()) {
               var spk = speaker.get();
               speakerDetail = spk.firstName() + " " + spk.lastName() + " (" + spk.company() + ")";
           }

           var lab = new SessionDetail(l.getTitle(), speakerDetail, String.valueOf(l.getVirtualRoom()), "Hands on Lab");
           response.send(lab.toJson());
       }

    } else {
       Util.sendError(response, 400, "SessionId not found : " + sessionId);
    }
}
```



Update Helidon's routing to add `getSessionDetails` as a handler for the "/detail" path.

```
@Override
public void update(Routing.Rules rules) {
   rules.get("/", this::getAll);
   rules.get("/detail/{sessionId}", this::getSessionDetails);
}
```

Although a bit long, the `getSessionDetails` method is easy to grasp. 


```
Optional<Session> session = sessions.getBySessionId(sessionId);
if (session.isPresent()) {
   record SessionDetail(String title, String speaker, String location, String type) {
   …
```

It first gets, from the Session list, a given session based on an Id. And if that session is found, a local record is defined…

```
if (s instanceof Keynote) {

   Keynote k = (Keynote) s;

   var speaker = speakers.getById(k.getKeynoteSpeaker());
   if (speaker.isPresent()) {
      var spk = speaker.get();
      speakerDetail = spk.firstName() + " " + spk.lastName() + " (" + spk.company() + ")";
   } else speakerDetail = "Keynote speaker to be announced!";

   var keynote = new SessionDetail("Keynote: " + k.getTitle(), speakerDetail, "Virtual Keynote hall", "General session");
   response.send(keynote.toJson());
```

Then, `instanceof` is used to test the actual type of the session, and based on this type, the logic to create the details will be slightly different. So this logic is repeated for the 3 sessions types, Keynote, Lecture, and Lab using a "`if … else if …`" chain.

If you zoom on the `instanceof` pattern, you will notice some verbosity as the type, Keynote in this example, is repeated 3 times. First for the actual `instanceof` test and then for the casting when a new intermediate locale varibale is created.

```
if (s instanceof Keynote) {
   Keynote k = (Keynote) s;
   // do something with k
   …
}
```

The 'pattern matching for instanceof' feature reduces that verbosity by defining a binding variable, k in this example, that will be created should the type test be true.

```
if (s instanceof Keynote k) {
   // do something with k
   …
}
// can't use k here!
```

You can now update the code to leverage the `pattern matching for instanceof` features for the 3 Session types.

```
if (s instanceof Keynote k) {
   var speaker = speakers.getById(k.getKeynoteSpeaker());
   …
} else if (s instanceof Lecture l) {
   var speaker = speakers.getById(l.getSpeaker());
   …
} else if (s instanceof Lab l) {
   var speaker = speakers.getById(l.getSpeaker());
   …
}
```

If you test the application now, you should session details varying depending on the session type.

## Wrap-up

In this exercice, you have used the 'pattern matching for instanceof' feature currently previewed in JDK 15 (2nd preview) and slated to be made standard and permanent in JDK 16.
For more details, please check [Pattern Matching for instanceof (Second Preview)](https://openjdk.java.net/jeps/375).

Do note that although the 'pattern matching for instanceof' feature unarguably simplifies the code, this method is still verbose. For example, the "`if … else if …`" chain makes this code a bit repetitive, wouldn't be nice to use a `switch` instead?  In fact, the 'pattern matching for instanceof' feature along with the Switch Expression (see Lab 9) will enable, in the future, full pattern matching support in the Java platform! 


