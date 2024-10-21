import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HandymanDashboard extends StatefulWidget {
  const HandymanDashboard({Key? key}) : super(key: key);

  @override
  State<HandymanDashboard> createState() => _HandymanDashboardState();
}

class _HandymanDashboardState extends State<HandymanDashboard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? handymanId; // Store handymanId once fetched
  bool isLoading = true; // To show a loading indicator while fetching handymanId

  @override
  void initState() {
    super.initState();
    _loadHandymanId();
  }

  Future<void> _loadHandymanId() async {
    // Fetch current user
    User? user = _auth.currentUser;
    if (user == null) {
      setState(() {
        isLoading = false;
      });
      return; // No user logged in
    }

    // Fetch the handymanId from the user's Firestore document
    DocumentSnapshot userDoc = await _firestore.collection('Users').doc(user.uid).get();
    if (userDoc.exists) {
      setState(() {
        handymanId = userDoc['handymanId']; // Store handymanId
        isLoading = false; // Stop loading
      });
    } else {
      setState(() {
        isLoading = false; // Stop loading even if no handymanId
      });
    }
  }

  // Real-time stream to fetch pending bookings for the current handyman
  Stream<QuerySnapshot> fetchPendingBookings() {
    if (handymanId == null) {
      return const Stream.empty(); // Return empty stream if handymanId is null
    }

    // Listen to real-time changes in the bookings collection for this handyman
    return _firestore
        .collection('bookings')
        .where('handymanId', isEqualTo: handymanId) // Match handymanId from Firestore
        .where('status', isEqualTo: 'Pending') // Only fetch pending bookings
        .snapshots();
  }

  // Handle booking acceptance
  Future<void> acceptBooking(String bookingId) async {
    await _firestore.collection('bookings').doc(bookingId).update({
      'status': 'Accepted',
    });
  }

  // Handle booking rejection
  Future<void> rejectBooking(String bookingId) async {
    await _firestore.collection('bookings').doc(bookingId).update({
      'status': 'Rejected',
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()), // Show loading indicator
      );
    }

    if (handymanId == null) {
      return const Scaffold(
        body: Center(child: Text('No handyman ID found')), // Show message if handymanId is null
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Handyman Dashboard', style: TextStyle(color: Colors.white)), // Text color changed to white
        centerTitle: true,
        backgroundColor: const Color(0xFF2C3333), // Header color changed
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF395B64)), // Icon color changed
          onPressed: () {
            Navigator.pop(context); // Pop the current page and go back
          },
        ),
      ),
      body: Container(
        color: const Color(0xFFE7F6F2), // Page color changed
        child: StreamBuilder<QuerySnapshot>(
          stream: fetchPendingBookings(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator()); // Show loading spinner
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No pending bookings.')); // Show message if no bookings
            }

            List<QueryDocumentSnapshot> bookings = snapshot.data!.docs;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  var booking = bookings[index].data() as Map<String, dynamic>;

                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Client ID: ${booking['clientId'] ?? 'N/A'}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text('Service: ${booking['service'] ?? 'N/A'}'),
                          const SizedBox(height: 4),
                          Text(
                            'Booking Time: ${booking['bookingTime'] != null 
                              ? (booking['bookingTime'] is Timestamp 
                                  ? (booking['bookingTime'] as Timestamp).toDate().toString() 
                                  : booking['bookingTime'].toString()) 
                              : 'N/A'}'
                          ), // Handle both Timestamp and DateTime safely
                          const SizedBox(height: 4),
                          Text('Handyman: ${booking['handymanName'] ?? 'N/A'}'),
                          const SizedBox(height: 4),
                          Text('Experience: ${booking['experience']?.toString() ?? 'N/A'} years'),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  acceptBooking(bookings[index].id); // Accept booking
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Accept'),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  rejectBooking(bookings[index].id); // Reject booking
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Reject'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
