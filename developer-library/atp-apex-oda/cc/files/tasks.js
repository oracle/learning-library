"use strict";

const fetch = require("node-fetch");

const ordsURL = "URL_COPIED_FROM_APEX";

function getTasks(urlRequest, logger, callback) {
logger.info(urlRequest);
fetch(urlRequest)
    .then((res) => {
    if (!res.ok) {
        const errorMessage = `Invalid status ${res.status}`;
        logger.error(errorMessage);
        callback(errorMessage);
        throw new Error(errorMessage);
    }
    return res.json();
    })
    .then((body) => {
    callback(null, body.items);
    })
    .catch((err) => {
    logger.error(err.message);
    callback(err.message);
    });
}

module.exports = {
    metadata: () => ({
        name: "com.example.tasks",
        supportedActions: ["success", "failure"],
    }),
    invoke: (conversation, done) => {
        getTasks(ordsURL, conversation.logger(), (err, data) => {
        if (err) {
            conversation.transition("failure");
            done();
            return;
        }
        const tasks = data.map((task) => task.text);
        conversation.reply(tasks.join("\n")).transition("success");
        done();
        });
    },
};