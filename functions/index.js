const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.sendEmergencyAlert = functions.https.onCall(async (data, context) => {
  const message = {
    notification: {
      title: "CITIZEN-107 ALERT",
      body: data.messageBody,
    },
    token: data.fcmToken,
  };

  try {
    const response = await admin.messaging().send(message);
    console.log("Successfully sent message:", response);
    return {success: true};
  } catch (error) {
    console.log("Error sending message:", error);
    throw new functions.https.HttpsError("internal", error.message);
  }
});
