import 'package:FixNow/time.dart'; // Ensure that SchedulePage or time.dart contains the correct implementation.
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth import
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore import

class Service {
  final IconData icon;
  final String title;
  final String description;

  Service({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class ServiceSelectionPage extends StatelessWidget {
  const ServiceSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final clientId = currentUser?.uid;

    final services = [
      Service(
        icon: Icons.plumbing,
        title: 'Plumbing',
        description: 'Expert plumbing services for all your needs.',
      ),
      Service(
        icon: Icons.power_settings_new,
        title: 'Electrical',
        description: 'Reliable electrical work for your home or business.',
      ),
      Service(
        icon: Icons.brush,
        title: 'Painting',
        description:
            'Professional painting services for interior and exterior.',
      ),
      Service(
        icon: Icons.handyman,
        title: 'General Handyman',
        description:
            'A variety of handyman services for your home or business.',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('FixNow!', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return ServiceCard(
            icon: service.icon,
            title: service.title,
            description: service.description,
            clientId: clientId!,
          );
        },
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String clientId;

  const ServiceCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
    required this.clientId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 48.0),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Text(title,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Text(description, style: const TextStyle(fontSize: 12.0)),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Navigate to handyman listing page with service and clientId
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HandymanListPage(
                        selectedService: title,
                        clientId: clientId,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00B4D8),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Select'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Handyman {
  final String handymanId;
  final String name;
  final String imageUrl;
  final int experience;
  final List<String> services;

  Handyman({
    required this.handymanId,
    required this.name,
    required this.imageUrl,
    required this.experience,
    required this.services,
  });

  factory Handyman.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Handyman(
      handymanId: doc.id,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      experience:int.tryParse(data['experience'].toString()) ?? 0,  // Convert to int safely
      services: data['services'] != null && data['services'] is List 
      ? List<String>.from(data['services']) 
      : [],  // Default to an empty list if services is null or not a list
    );
  }

  @override
  String toString() {
    return '$name';
  }
}


class HandymanListPage extends StatefulWidget {
  final String selectedService;
  final String clientId;

  const HandymanListPage({
    Key? key,
    required this.selectedService,
    required this.clientId,
  }) : super(key: key);

  @override
  State<HandymanListPage> createState() => _HandymanListPageState();
}

class _HandymanListPageState extends State<HandymanListPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Handyman>> fetchHandymen() async {
    // Query Firestore to get handymen who offer the selected service
    QuerySnapshot snapshot = await _firestore
        .collection('handy_profile')
        .where('services', arrayContains: widget.selectedService)
        .get();

        // Add this debug print
  print('Handymen fetched: ${snapshot.docs.length}');
  

    // Map each document to Handyman using the fromFirestore factory constructor
  return snapshot.docs.map((doc) => Handyman.fromFirestore(doc)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Handymen for ${widget.selectedService}'),
      ),
      body: FutureBuilder<List<Handyman>>( // Change here
        future: fetchHandymen(),
        
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching handymen.'));
          }

          final handymen = snapshot.data;

           // Add this debug print to check the fetched handymen data
          print('Handymen data: $handymen');

          if (handymen == null || handymen.isEmpty) {
            return const Center(child: Text('No handymen available.'));
          }

          return ListView.builder(
            itemCount: handymen.length,
            itemBuilder: (context, index) {
              final handyman = handymen[index];
              return HandymanCard(
                handymanObject: handyman,
                selectedService: widget.selectedService,
                clientId: widget.clientId,
              );
            },
          );
        },
      ),
    );
  }
}

class HandymanCard extends StatelessWidget {
  final Handyman handymanObject;
  final String selectedService;
  final String clientId;

  const HandymanCard({
    Key? key,
    required this.handymanObject,
    required this.selectedService,
    required this.clientId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

     // Convert the map to a Handyman object
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(handymanObject.imageUrl),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    handymanObject.name,
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                    
                      
                      const SizedBox(width: 8.0),
                      Text(
                        '(${handymanObject.experience} years exp.)',
                        style:
                            const TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Services: ${handymanObject.services.join(', ')}',
                    style: const TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                print('Handyman ID: ${handymanObject.handymanId}');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SchedulePage(
                      handymanId: handymanObject.handymanId,
                      handymanName: handymanObject.name,
                      handymanExperience:handymanObject.experience,
                      selectedService: selectedService,
                      clientId: clientId,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00B4D8),
                foregroundColor: Colors.white,
              ),
              child: const Text('Book Now'),
            ),
          ],
        ),
      ),
    );
  }
}
