import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'main.dart';

class CompetitionPage extends StatelessWidget {
  final String ? initialSection;
  final _introKey = GlobalKey();
  final _categoryKey = GlobalKey();
  final _registrationKey = GlobalKey();
  final _faqKey = GlobalKey();
  
  CompetitionPage({super.key, this.initialSection});

  @override
  Widget build(BuildContext context) {
    if (initialSection != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToSection(context,initialSection!);
      });
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: MakerFairbar(
          title: const Text('PETROBOTS Maker Fair 2026'),
          onNavigate: (section) {

            if (['category', 'registration', 'faq'].contains(section)) {
              _scrollToSection(context, section);
            } else if (['about', 'support', 'contact'].contains(section)) {
              Navigator.pop(context, section);
            } else if (section == 'competition') {
              Scrollable.ensureVisible(
                _introKey.currentContext!,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
          onSearch: () => _showSearch(context),
          onLogo: (){ Navigator.pop(context, 'home');},
        )
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIntro(context, key: _introKey),
            const SizedBox(height: 32),
            _buildCategory(context, key: _categoryKey),
            const SizedBox(height: 32),
            _buildRegistration(context, key: _registrationKey),
            const SizedBox(height: 32),
            _buildFAQ(context, key: _faqKey),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
  bool _scrollToSection(BuildContext context, String section) {
    late final GlobalKey targetKey;
    switch (section) {
      case 'category':
        targetKey = _categoryKey;
        break;
      case 'registration':
        targetKey = _registrationKey;
        break;
      case 'faq':
        targetKey = _faqKey;
        break;
      default:
        return false;
    }
    final scrollContext = targetKey.currentContext;
    if (scrollContext != null) {
      Scrollable.ensureVisible(
        scrollContext,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.1,
      );
      return true;
    }
    return false;
  }

  Widget _buildIntro(BuildContext context, {Key? key}) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PETROBOTS RoboTrack GP 2026',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF001F3F),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Welcome to the ultimate robotics competition! Showcase your innovation, engineering skills, and creativity on the global stage.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.grey[800],
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),

        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF001F3F).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF001F3F).withOpacity(0.3)),
          ),
          child: const Center(
            child: Text(
              'RoboTrack GP Banner',
              style: TextStyle(color: Color(0xFF001F3F), fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategory(BuildContext context, {Key? key}) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Competition Categories',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF001F3F),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'The RoboTrack GP tournament is divided into two distinct categories based on technical experience and hardware capabilities:',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.grey[800],
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),

        _buildCategoryCard(
          context,
          'Expert Category',
          'Secondary School / University Level',
          '• LEGO or Arduino (8-bit Atmel) platforms\n'
          '• Maximum 2 motors for locomotion\n'
          '• Maximum 2 IR sensors only\n'
          '• Max voltage: 9.6V (2S LiPo or 6x AA)\n'
          '• Robot footprint: 25cm x 25cm\n'
          '• Entry Fee: RM200 (Local) / \$100 (International)\n'
          '• Prizes: 1st RM2000 | 2nd RM1500 | 3rd RM1000',
          Colors.blueGrey,
        ),
        const SizedBox(height: 16),

        _buildCategoryCard(
          context,
          'Grandmaster Category',
          'University / Open Level (Professionals Welcome)',
          '• Any microcontroller (ESP32, STM32, Raspberry Pi, etc.)\n'
          '• No limit on motors or sensors\n'
          '• Encoders & advanced sensors allowed\n'
          '• Max voltage: 12.6V (3S LiPo)\n'
          '• Robot footprint: 25cm x 25cm\n'
          '• Entry Fee: RM300 (Local) / \$150 (International)\n'
          '• Prizes: 1st RM3000 | 2nd RM2000 | 3rd RM1500',
          const Color(0xFF001F3F),
        ),
        const SizedBox(height: 24),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.amber[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber[200]!),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.amber[700]),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Note: All robots must undergo mandatory technical inspection 30 minutes before the tournament. Wireless modules (Bluetooth/Wi-Fi) must be disabled during official runs.',
                  style: TextStyle(color: Colors.amber[900], fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    String title,
    String subtitle,
    String description,
    Color BorderColor,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: BorderColor.withOpacity(0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: BorderColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: BorderColor)),
          const SizedBox(height: 8),
          Text(subtitle, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.grey[800])),
          const SizedBox(height: 12),
          Text(description, style: TextStyle(color: Colors.grey[700], fontSize: 14, height: 1.8)),
        ],
      ),
    );
  }

  Widget _buildRegistration(BuildContext context, {Key? key}) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Register for RoboTrack GP',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF001F3F),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Ready to compete? Click the button below to open the registration form.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey[800]),
        ),
        const SizedBox(height: 24),

        ElevatedButton.icon(
          onPressed: () async {
            final uri = Uri.parse('https://forms.office.com/r/YrcvZ61nTff');
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            }
          },
          icon: const Icon(Icons.open_in_new),
          label: const Text('Open Registration Form'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF001F3F),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
        ),

        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Registration Fees:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('• Expert: RM200 (Local) / \$100 (International)', style: TextStyle(color: Colors.grey[800])),
              Text('• Grandmaster: RM300 (Local) / \$150 (International)', style: TextStyle(color: Colors.grey[800])),
              const SizedBox(height: 8),
              Text('Includes: Participation certificate, door gift, 3 meals/day, Award Night access',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFAQ(BuildContext context, {Key? key}) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ' Frequently Asked Questions (FAQ)',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF001F3F),
          ),
        ),
        const SizedBox(height: 16),

        _buildFAQItem('When is the competition?', 'PETROBOTS Maker Fair 2026 will be held on 27th-28th June 2026 at Universiti Teknologi PETRONAS (UTP).'),
        _buildFAQItem('What are the team size limits?', 'Teams must have 1-3 participants. One adult mentor is allowed for supervision but cannot program or handle the robot during runs.'),
        _buildFAQItem('Is there a registration fee?', 'Yes: Expert RM200/\$100, Grandmaster RM300/\$150. Fees include certificates, meals, door gifts, and Award Night access.'),
        _buildFAQItem('Can I use any microcontroller?', 'Expert: Only LEGO or 8-bit Arduino (Uno/Nano/Mega). Grandmaster: Any controller (ESP32, STM32, Raspberry Pi, etc.).'),
        _buildFAQItem('What about sensors?', 'Expert: Max 2 IR sensors only. Grandmaster: No limits — IR arrays, cameras, encoders all allowed.'),
        _buildFAQItem('Is technical inspection required?', 'Yes! All robots must pass mandatory inspection 30 minutes before the tournament. Failed robots get 15 minutes to fix or face disqualification.'),
      ],
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: ExpansionTile(
        title: Text(question, style: const TextStyle(fontWeight: FontWeight.w600)),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(answer, style: TextStyle(color: Colors.grey[800])),
          ),
        ],
      ),
    );
  }

void _showSearch(BuildContext context) {
    final searching = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🔍 Search'),
        content: TextField(
          controller: searching,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search: about, support, contact, category, registration, faq...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
          onSubmitted: (query) => _searchQuery(context, query, searching),
        ),
        actions: [
          TextButton(
            onPressed: () {
              searching.clear();
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final query = searching.text.trim();
              _searchQuery(context, query, searching);
            },
            child: const Text('Search'),
          ),
        ],
      ),
    ).then((_) => searching.dispose()); 
  }

  void _searchQuery(BuildContext context, String query, TextEditingController searching) {
    final lowerQuery = query.toLowerCase().trim();
    
    if (['about', 'support', 'contact'].contains(lowerQuery)) {
      Navigator.pop(context); 
   
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Returning to HomePage for "$lowerQuery"...')),
      );
      Navigator.pop(context, lowerQuery); 
    } 
    else if (['category', 'registration', 'faq', 'competition'].contains(lowerQuery)) {
      Navigator.pop(context);

      if (['category', 'registration', 'faq'].contains(lowerQuery)) {

        if (_scrollToSection(context, lowerQuery)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Scrolled to "$lowerQuery" section')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Could not scroll to "$lowerQuery" section'),
              backgroundColor: Colors.amber,
            ),
          );
        }
      } else {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('🔍 Scrolling to top of CompetitionPage')),
        );
        Scrollable.ensureVisible(
          _introKey.currentContext!,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } 
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(' No results found for "$query"'),
          backgroundColor: Colors.amber,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}   