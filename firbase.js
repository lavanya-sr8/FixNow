// firebase.js
const admin = require('firebase-admin');
const serviceAccount = require('C:/Users/91948/Downloads/fixnow-c4253-firebase-adminsdk-f7y7a-f3e5f95b68.json'); // Update the path

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

// Function to send notifications
const sendNotification = async (fcmToken, bookingDetails) => {
   const payload = {
     notification: {
       title: "New Booking Request",
       body: `You have a new booking on ${bookingDetails.date} at ${bookingDetails.time}.`,
     },
   };

   try {
     const response = await admin.messaging().sendToDevice(fcmToken, payload);
     console.log("Successfully sent message:", response);
   } catch (error) {
     console.error("Error sending message:", error);
   }
};

module.exports = {
  sendNotification,
};
