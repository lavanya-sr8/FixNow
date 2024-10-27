import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:FixNow/time.dart';

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
      Service(icon: Icons.plumbing, title: 'Plumbing', description: 'Expert plumbing services.'),
      Service(icon: Icons.power_settings_new, title: 'Electrical', description: 'Reliable electrical work.'),
      Service(icon: Icons.brush, title: 'Painting', description: 'Professional painting services.'),
      Service(icon: Icons.handyman, title: 'General Handyman', description: 'Various handyman services.'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('FixNow!', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF2C3333),
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
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48.0, color: const Color(0xFF395B64)),
              const SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF395B64),
                  ),
                ),
              ),
            ],
          ),
          Text(description),
          ElevatedButton(
            onPressed: () {
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
            child: const Text('Select'),
          ),
        ],
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
  final List<String> preferredLocalities;

  Handyman({
    required this.handymanId,
    required this.name,
    required this.imageUrl,
    required this.experience,
    required this.services,
    required this.preferredLocalities,
  });

  factory Handyman.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Handyman(
      handymanId: doc.id,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      experience: int.tryParse(data['experience'].toString()) ?? 0,
      services: List<String>.from(data['services'] ?? []),
      preferredLocalities: List<String>.from(data['preferredLocalities'] ?? []),
    );
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
  String? selectedLocality;
  List<String> localities = [
    'Gandhipuram',
    'R S Puram',
    'Peelamedu',
    'Singanallur',
    'Saibaba Colony',
    'Ukkadam',
    'Sivananda Colony',
    'Vadavalli',
    'Sulur',
    'Thudiyalur',
    'Karamadai',
    'Ramanathapuram',
    'Sundarapuram',
    'Kovaipudur',
    'Podanur',
    'Perur',
    'Town Hall',
    'Race Course',
    'Saravanampatti'
  ];

  Future<List<Handyman>> fetchHandymen(String selectedLocality) async {
    QuerySnapshot snapshot = await _firestore
        .collection('handy_profile')
        .where('services', arrayContains: widget.selectedService)
        .get();

    return snapshot.docs
        .map((doc) => Handyman.fromFirestore(doc))
        .where((handyman) => handyman.preferredLocalities.contains(selectedLocality))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Handymen for ${widget.selectedService}'),
        backgroundColor: const Color(0xFF2C3333),
      ),
      body: Column(
        children: [
          DropdownButtonFormField<String>(
            hint: const Text("Select Your Locality"),
            value: selectedLocality,
            items: localities.map((locality) {
              return DropdownMenuItem(
                value: locality,
                child: Text(locality),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedLocality = value;
              });
            },
          ),
          Expanded(
            child: selectedLocality == null
                ? const Center(child: Text('Please select a locality'))
                : FutureBuilder<List<Handyman>>(
                    future: fetchHandymen(selectedLocality!),
                    builder: (context, handymenSnapshot) {
                      if (handymenSnapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (handymenSnapshot.hasError) {
                        return const Center(child: Text('Error fetching handymen.'));
                      }
                      final handymen = handymenSnapshot.data ?? [];
                      if (handymen.isEmpty) {
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
          ),
        ],
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
    return Card(
      child: Row(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(handymanObject.imageUrl)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(handymanObject.name, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                Text('${handymanObject.experience} years experience'),
                Text('Services: ${handymanObject.services.join(', ')}'),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate to booking page
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SchedulePage(
                      handymanId: handymanObject.handymanId,
                      handymanName: handymanObject.name,
                      handymanExperience: handymanObject.experience,
                      selectedService: selectedService,
                      clientId: clientId,
                    ),
                  ),
                );
            },
            child: const Text('Book Now'),
          ),
        ],
      ),
    );
  }
}