import 'package:flutter/material.dart';

class Service {
  final IconData icon;
  final String title;
  final String description;

  Service({required this.icon, required this.title, required this.description});
}

class ServiceSelectionPage extends StatelessWidget {
  const ServiceSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
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
        description: 'Professional painting services for interior and exterior.',
      ),
      Service(
        icon: Icons.handyman,
        title: 'General Handyman',
        description: 'A variety of handyman services for your home or business.',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('FixNow!',style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade900,centerTitle: true, ),
      body: ListView.builder(
        itemCount: services.length, // Replace with your service list
        itemBuilder: (context, index) {
          final service = services[index];
          return ServiceCard(
            icon: service.icon,
            title: service.title,
            description: service.description,
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

  const ServiceCard({super.key, 
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal:
 16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: 
 [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
 // Center the icon and title
                children: [
                  Icon(icon, size: 48.0),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Text(description, style: const TextStyle(fontSize: 12.0)),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Navigate to service details page or request quote
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue, // Light blue background
                  foregroundColor: Colors.white, // White text
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