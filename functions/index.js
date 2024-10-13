/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// const {onRequest} = require("firebase-functions/v2/https");
// const logger = require("firebase-functions/logger");
const functions = require("firebase-functions");
const admin = require("firebase-admin");

// Initialize Firebase Admin SDK
admin.initializeApp();

exports.sendBookingNotification = functions.firestore
    .document("Bookings/{bookingId}")
    .onCreate(async (snap, context) => {
      const bookingData = snap.data();

      // Get the handymanId and booking details
      const handymanId = bookingData.handymanId;

      // Fetch the handyman's FCM token from the database
      const handymanRef = admin.firestore().collection("Handymen")
          .doc(handymanId);
      const handymanDoc = await handymanRef.get();

      if (!handymanDoc.exists) {
        console.log("Handyman does not exist!");
        return;
      }

      const fcmToken = handymanDoc.data().fcmToken; // FCM token

      // Define the notification payload
      const payload = {
        notification: {
          title: "New Booking Request",
          body: `You have a new booking on ${bookingData.date} 
              at ${bookingData.time}.`,
        },
      };

      // Send the notification to the handyman's device
      return admin.messaging().sendToDevice(fcmToken, payload)
          .then((response) => {
            console.log("Successfully sent message:", response);
          })
          .catch((error) => {
            console.error("Error sending message:", error);
          });
    });
