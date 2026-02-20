import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'competition_page.dart';
import 'main.dart';

class HomePage extends StatelessWidget {
 
  final _aboutKey = GlobalKey();
  final _supportKey = GlobalKey();
  final _contactKey = GlobalKey();
  final _scrollController = ScrollController();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: MakerFairbar(
          title: const Text('PETROBOTS Maker Fair 2026'),
          onNavigate:(section){
            if(section =='competition'){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CompetitionPage(initialSection: null,)),
              ).then((result){
                if(result is String && ['about', 'support', 'contact'].contains(result)){
                  _scrollToSection(context, result);
                } else if(result == 'home'){
                  _scrolltoTop(context);
                }
              });
            } else if(['category', 'registration', 'faq'].contains(section)) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CompetitionPage(initialSection: section)),
              ).then((result){
                if(result is String && ['about', 'support', 'contact'].contains(result)){
                  _scrollToSection(context, result);
                } else if(result == 'home'){
                  _scrolltoTop(context);
                }
              });
             } else {
              _scrollToSection(context, section);
            }
          },
          onSearch: () => _showSearch(context),
          onLogo: () => _scrolltoTop(context),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            _buildHeroSection(context),
            _buildAboutSection(context, key: _aboutKey),
            _buildSupportSection(context, key: _supportKey),
            _buildContactSection(context, key: _contactKey),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  bool _scrollToSection(BuildContext context, String section) {
    late final GlobalKey targetKey;
    switch (section) {
      case 'about':
        targetKey = _aboutKey;
        break;
      case 'support':
        targetKey = _supportKey;
        break;
      case 'contact':
        targetKey = _contactKey;
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

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: double.infinity,  
      decoration: BoxDecoration(
        color: const Color(0xFF001F3F), 
        image: DecorationImage(
          image: AssetImage('assets/hero-background.jpg'), 
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            const Color(0xFF001F3F).withOpacity(0.7), 
            BlendMode.multiply,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'PETROBOTS Maker Fair 2026',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Engineering Intelligence with Robotics and Automation',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            '27th-28th June 2026 | Universiti Teknologi PETRONAS (UTP)',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CompetitionPage(initialSection: null)),
                  ).then((result){
                    if(result is String && ['about', 'support', 'contact'].contains(result)){
                      _scrollToSection(context, result);
                    } else if (result == 'home'){
                      _scrolltoTop(context);
                    }
                  });
                },
                child: const Text('Explore Competition'),
              ),
              const SizedBox(width: 16),
              OutlinedButton(
                onPressed: () => _scrollToSection(context, 'support'), 
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                ),
                child: const Text('Support Us'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context, {Key? key}) {
    return Column( 
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(40),
          child: Text(
            'About PETROBOTS Maker Fair',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'UTP Robotics Society (PETROBOTS) is a well-established robotics society that has been active for a long time at UTP. Originally formed to compete in ROBOCON, it has gradually evolved to serve as a platform for undergraduate robotics advancement for students from diverse backgrounds.',
            style: TextStyle(fontSize: 16, height: 1.6),
          ),
        ),
        const SizedBox(height: 24),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildHighlightCard('Robotics & AI', 'Hands-on experience with autonomous robots and artificial intelligence.'),
              _buildHighlightCard('Hands-on Learning', 'Workshops and competitions that build practical engineering skills.'),
              _buildHighlightCard('Industry Exposure', 'Connect with leading tech companies specializing in automation and IoT.'),
            ],
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildHighlightCard(String title, String description) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF001F3F).withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          Text(description, style: TextStyle(color: Colors.grey[700], fontSize: 14)),
        ],
      ),
    );
  }
  Widget _buildSupportSection(BuildContext context, {Key? key}) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(40),
          child: Text(
            'Support the Event',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildContributorCard(context)),
                    const SizedBox(width: 24),
                    Expanded(child: _buildSponsorCard(context)),
                  ],
                );
              } else {

                return Column(
                  children: [
                    _buildContributorCard(context),
                    const SizedBox(height: 24),
                    _buildSponsorCard(context),
                  ],
                );
              }
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          child: Text(
            'Contributor support does not include branding, publicity, or commercial benefits and follows UTP financial governance policy.',
            style: TextStyle(fontSize: 11, color: Colors.grey, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildContributorCard(BuildContext context) {
    return Card(
      color: Colors.blue[50],
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Contributor Support', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Text(
              'Non-commercial support for the event. Appreciation-based contribution to foster maker culture.',
              style: TextStyle(height: 1.6),
            ),
            const SizedBox(height: 16),
            ExpansionTile(
              title: const Text('What Contributors Receive'),
              children: const [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• Appreciation certificate'),
                      Text('• Eligible for Tax Exemption'),
                      Text('• Post-event impact report'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('ASSISTANT HEAD OF SPONSORSHIP DEPARTMENT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const Text('Muhammad Danish Abqari bin Syafiq Jasrin ', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                final uri = Uri.parse('mailto:muhammad_24006039@utp.edu.my');
                if (await canLaunchUrl(uri)) await launchUrl(uri);
              },
              child: const Text('Contact as Contributor'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSponsorCard(BuildContext context) {
    return Card(
      color: Colors.amber[50],
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Event Sponsorship', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Text(
              'Commercial partnership opportunities with branding, engagement, and social media exposure.',
              style: TextStyle(height: 1.6),
            ),
            const SizedBox(height: 16),
            ExpansionTile(
              title: const Text('What Sponsors Receive'),
              children: const [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• Logo placement on event materials'),
                      Text('• Not Eligible for Tax Exemption'),
                      Text('• Social media exposure'),
                      Text('• Opening & closing ceremony mention'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('HEAD OF SPONSORSHIP DEPARTMENT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const Text('Ammar Dzulkarnain bin Muhammad Najib', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                final uri = Uri.parse('mailto:ammar_22010519@utp.edu.my');
                if (await canLaunchUrl(uri)) await launchUrl(uri);
              },
              child: const Text('Contact as Sponsor'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection(BuildContext context, {Key? key}) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(40),
          child: Text(
            'Contact Us',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildContactItem('Project Director', 'Jonathan Voon Yen Jie', 'yen_22011091@utp.edu.my'),
              _buildContactItem('Sponsorship & Partnerships', 'Ammar Dzulkarnain bin Muhammad Najib', 'ammar_22010519@utp.edu.my'),
              _buildContactItem('General Enquiries', 'Geoffrey Lee Jin Yau', 'geoffrey_24006190@utp.edu.my'),
            ],
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildContactItem(String role, String name, String email) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(role, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(name, style: TextStyle(color: Colors.grey[700])),
          InkWell(
            onTap: () async {
              final uri = Uri.parse('mailto:$email');
              if (await canLaunchUrl(uri)) await launchUrl(uri);
            },
            child: Text(
              email,
              style: const TextStyle(color: Color(0xFF001F3F), decoration: TextDecoration.underline),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      color: const Color(0xFF001F3F),
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          // Logo placeholder
          SizedBox(
            height: 60,
            child: Image.asset(
              'assets/petrobots logo.png',
              color: Colors.white,
              errorBuilder: (context, error, stackTrace) =>
                  const Text('PETROBOTS', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 16),
          // Social icons placeholder
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                final uri = Uri.parse('https://www.instagram.com/petrobotsmakerfair.utp?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw==');  // 🔧 REPLACE WITH YOUR LINK
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Image.asset(
                    'assets/icons/instagram.png',
                    height: 32,
                    width: 32,
                    color: Colors.white,
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  final uri = Uri.parse('https://www.linkedin.com/company/utp-petrobots/posts/?feedView=all');  // 🔧 REPLACE WITH YOUR LINK
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Image.asset(
                    'assets/icons/linkedin.png',
                    height: 32,
                    width: 32,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          const Text(
            'PETROBOTS Maker Fair 2026',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 8),
          const Text(
            'Universiti Teknologi PETRONAS (UTP), 32610 Seri Iskandar, Perak, Malaysia',
            style: TextStyle(color: Colors.white, fontSize: 12),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'This event is organized by UTP PETROBOTS Student Society (UTP PETROBOTS)',
            style: TextStyle(color: Colors.white30, fontSize: 10),
            textAlign: TextAlign.center,
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
        title: const Text('Search'),
        content: TextField(
          controller: searching,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search: about, support, contact, category, registration, faq',
            prefixIcon: Icon( Icons.search),
            border: OutlineInputBorder(),
          ),
          onSubmitted: (query) => _searchquery(context, query, searching),
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
            _searchquery(context, query, searching);
          },
          child: const Text('Search'),
        ),
      ],
      ),
    ).then((_) {searching.dispose();});
  }

  void _searchquery(BuildContext context, String query, TextEditingController searching) {
    final lowerQuery = query.toLowerCase().trim();

    if (['about', 'support', 'contact'].contains(lowerQuery)) {
      Navigator.pop(context); 
      
      if (_scrollToSection(context, lowerQuery)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Scrolled to "$lowerQuery" section')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Returning to HomePage for "$lowerQuery"...'),
            backgroundColor: Colors.amber,
          ),
        );
        Navigator.pop(context);
      }
    } 
    else if (['category', 'registration', 'faq', 'competition'].contains(lowerQuery)) {
      Navigator.pop(context); // Close search dialog
      
      if (['category', 'registration', 'faq'].contains(lowerQuery)) {
        if (_scrollToSection(context, lowerQuery)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Scrolled to "$lowerQuery" section')),
          );
        } else {

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Navigating to CompetitionPage for "$lowerQuery"...'),
              backgroundColor: Colors.amber,
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CompetitionPage(
                initialSection: lowerQuery,
              ),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Scrolling to top of CompetitionPage')),
        );

      }
    } 

    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No results found for "$query"'),
          backgroundColor: Colors.amber,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _scrolltoTop(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(0.0);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Returned to HomePage top'),
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          ),
      );
    });
  }
}

