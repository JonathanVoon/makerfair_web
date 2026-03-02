import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'competition_page.dart';
import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _aboutKey = GlobalKey();
  final _supportKey = GlobalKey();
  final _contactKey = GlobalKey();
  final _scrollController = ScrollController();
  
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;
  Timer? _slideshowTimer;
 
  static const String _marketingProposalUrl = 'https://utpmy-my.sharepoint.com/:b:/g/personal/yen_22011091_utp_edu_my/IQBtt2nVqMGoRpFMeiY8VHjoAYAn2rhi2kgjKn2C2GU9ZYs?e=u7DBLP';

  final List<String> _heroImages = [
    'assets/Group-photo-Makerfair25.png',
    'assets/IMG_0629.png',
    'assets/IMG_3451.png', 
    'assets/IMG_3546.png',
    'assets/IMG_3641.png',
  ];

  @override
  void initState() {
    super.initState();
    _startSlideshow();
  }

  @override
  void dispose() {
    _slideshowTimer?.cancel();
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _startSlideshow() {
    _slideshowTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_currentImageIndex < _heroImages.length - 1) {
        _currentImageIndex++;
      } else {
        _currentImageIndex = 0;
      }
      _pageController.animateToPage(
        _currentImageIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      if (mounted) setState(() {});
    });
  }

  void _goToImage(int index) {
    _currentImageIndex = index;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    if (mounted) setState(() {});
  }

  TextStyle _bigWordStyle({double fontSize = 32, Color? color}) {
    return TextStyle(
      fontFamily: 'Bungee',  
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: color ?? const Color(0xFF001F3F),
    );
  }

  TextStyle _smallWordStyle({double fontSize = 16, Color? color}) {
    return TextStyle(
      fontFamily: 'Archivo Black',  
      fontSize: fontSize,
      color: color ?? Colors.grey[800],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: MakerFairbar(
          title: const Text('PETROBOTS Maker Fair 2026'),
          onNavigate: (section) {
            if (!context.mounted) return;
            
            if (section == 'competition') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CompetitionPage(initialSection: null)),
              ).then((result) {
                if (!context.mounted) return;
                if (result is String && ['about', 'support', 'contact'].contains(result)) {
                  _scrollToSection(context, result);
                } else if (result == 'home') {
                  _scrolltoTop(context);
                }
              });
            } else if (['category', 'registration', 'faq'].contains(section)) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CompetitionPage(initialSection: section)),
              ).then((result) {
                if (!context.mounted) return;
                if (result is String && ['about', 'support', 'contact'].contains(result)) {
                  _scrollToSection(context, result);
                } else if (result == 'home') {
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
      
      if (!context.mounted) return false;
      
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
    return Column(
      children: [
        Container(
          height: 7,
          width: double.infinity,
          color: const Color(0xFFD4AF37),
        ),
        
        Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: double.infinity,  
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: _heroImages.length,
                onPageChanged: (index) {
                  if (mounted) {
                    setState(() {
                      _currentImageIndex = index;
                    });
                  }
                },
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF001F3F), 
                      image: DecorationImage(
                        image: AssetImage(_heroImages[index]), 
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          const Color(0xFF001F3F).withOpacity(0.55), 
                          BlendMode.multiply,
                        ),
                      ),
                    ),
                  );
                },
              ),
              
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'PETROBOTS Maker Fair 2026',
                      style: _bigWordStyle(fontSize: 48, color: Colors.white),  
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Engineering Intelligence with Robotics and Automation',
                      style: _bigWordStyle(fontSize: 24, color: Colors.white),  
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '27th-28th June 2026 | Universiti Teknologi PETRONAS (UTP)',
                      style: _smallWordStyle(fontSize: 16, color: Colors.white),  
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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white, 
                            side: const BorderSide(color: Colors.white), 
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          ),
                          child: Text(
                            'Explore Competition',
                            style: _smallWordStyle(fontSize: 16, color: Colors.white),  
                          ),
                        ),
                        const SizedBox(width: 16),
                        OutlinedButton(
                          onPressed: () => _scrollToSection(context, 'support'), 
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                          ),
                          child: Text(
                            'Support Us',
                            style: _smallWordStyle(fontSize: 16, color: Colors.white), 
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              Positioned(
                bottom: 24,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _heroImages.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentImageIndex == index ? 12 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentImageIndex == index 
                            ? Colors.white 
                            : Colors.white.withOpacity(0.5),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _goToImage(index),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        Container(
          height: 7,
          width: double.infinity,
          color: const Color(0xFFD4AF37),
        ),
      ],
    );
  }

  Widget _buildAboutSection(BuildContext context, {Key? key}) {
    return Column( 
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(40),
          child: Text(
            'About PETROBOTS Maker Fair',
            style: _bigWordStyle(fontSize: 32),  
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'UTP Robotics Society (PETROBOTS) is a well-established robotics society that has been active for a long time at UTP. Originally formed to compete in ROBOCON, it has gradually evolved to serve as a platform for undergraduate robotics advancement for students from diverse backgrounds.',
            style: _smallWordStyle(fontSize: 16, color: Colors.grey[800]).copyWith(height: 1.6),  
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
              _buildHighlightCard('Hands-on Learning', 'Competitions that build practical engineering skills.'),
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
          Text(
            title,
            style: _bigWordStyle(fontSize: 18),  
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: _smallWordStyle(fontSize: 14, color: Colors.grey[700]),  
          ),
        ],
      ),
    );
  }

  Widget _buildSupportSection(BuildContext context, {Key? key}) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(40),
          child: Text(
            'Support the Event',
            style: _bigWordStyle(fontSize: 32), 
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          child: Text(
            'Contributor support does not include branding, publicity, or commercial benefits and follows UTP financial governance policy.',
            style: _smallWordStyle(fontSize: 11, color: Colors.grey).copyWith(fontStyle: FontStyle.italic),  
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
            Text(
              'Contributor Support',
              style: _bigWordStyle(fontSize: 20),  
            ),
            const SizedBox(height: 12),
            Text(
              'Non-commercial support for the event. Appreciation-based contribution to foster maker culture.',
              style: _smallWordStyle(fontSize: 14).copyWith(height: 1.6),  
            ),
            const SizedBox(height: 16),
            ExpansionTile(
              title: Text(
                'What Contributors Receive',
                style: _bigWordStyle(fontSize: 16).copyWith(fontWeight: FontWeight.w600),  
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• Eligible for Tax Exemption', style: _smallWordStyle(fontSize: 13)), 
                      Text('• Post-event impact report', style: _smallWordStyle(fontSize: 13)), 
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'ASSISTANT HEAD OF SPONSORSHIP DEPARTMENT',
              style: _bigWordStyle(fontSize: 12), 
            ),
            Text(
              'Muhammad Danish Abqari bin Syafiq Jasrin ',
              style: _smallWordStyle(fontSize: 14).copyWith(fontWeight: FontWeight.w500),  
            ),
            const SizedBox(height: 12),
            
            ElevatedButton.icon(
              onPressed: () async {
                final uri = Uri.parse(_marketingProposalUrl);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('⚠️ Could not open marketing proposal')),
                  );
                }
              },
              icon: const Icon(Icons.download, size: 18),
              label: const Text('View Marketing Proposal'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF001F3F),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
            
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF001F3F),
                  foregroundColor: Colors.white, 
                  side: const BorderSide(color: Colors.white), 
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
              onPressed: () async {
                final uri = Uri.parse('mailto:muhammad_24006039@utp.edu.my');
                if (await canLaunchUrl(uri)) await launchUrl(uri);
              },
              child: Text(
                'Contact as Contributor',
                style: _smallWordStyle(fontSize: 14, color: Colors.white),  
              ),
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
            Text(
              'Event Sponsorship',
              style: _bigWordStyle(fontSize: 20), 
            ),
            const SizedBox(height: 12),
            Text(
              'Commercial partnership opportunities with branding, engagement, and social media exposure.',
              style: _smallWordStyle(fontSize: 14).copyWith(height: 1.6), 
            ),
            const SizedBox(height: 16),
            ExpansionTile(
              title: Text(
                'What Sponsors Receive',
                style: _bigWordStyle(fontSize: 16).copyWith(fontWeight: FontWeight.w600),  
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• Logo placement on event materials', style: _smallWordStyle(fontSize: 13)), 
                      Text('• Not Eligible for Tax Exemption', style: _smallWordStyle(fontSize: 13)), 
                      Text('• Companies are eligible to register for exhibition booths ', style: _smallWordStyle(fontSize: 13)), 
                      Text('• Social media exposure', style: _smallWordStyle(fontSize: 13)),  
                      Text('• Opening & closing ceremony mention', style: _smallWordStyle(fontSize: 13)),  
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'HEAD OF SPONSORSHIP DEPARTMENT',
              style: _bigWordStyle(fontSize: 12),  
            ),
            Text(
              'Lim Ming Yang',
              style: _smallWordStyle(fontSize: 14).copyWith(fontWeight: FontWeight.w500), 
            ),
            const SizedBox(height: 12),
            
            ElevatedButton.icon(
              onPressed: () async {
                final uri = Uri.parse(_marketingProposalUrl);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('⚠️ Could not open marketing proposal')),
                  );
                }
              },
              icon: const Icon(Icons.download, size: 18),
              label: const Text('View Marketing Proposal'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF001F3F),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
            
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF001F3F),
                  foregroundColor: Colors.white, 
                  side: const BorderSide(color: Colors.white), 
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
              onPressed: () async {
                final uri = Uri.parse('mailto:lim_24005921@utp.edu.my');
                if (await canLaunchUrl(uri)) await launchUrl(uri);
              },
              child: Text(
                'Contact as Sponsor',
                style: _smallWordStyle(fontSize: 14, color: Colors.white), 
              ),
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
        Padding(
          padding: const EdgeInsets.all(40),
          child: Text(
            'Contact Us',
            style: _bigWordStyle(fontSize: 32), 
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildContactItem('Project Director', 'Jonathan Voon Yen Jie', 'yen_22011091@utp.edu.my'),
              _buildContactItem('Sponsorship & Partnerships', 'Lim Ming Yang', 'lim_24005921@utp.edu.my'),
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
          Text(
            role,
            style: _bigWordStyle(fontSize: 16), 
          ),
          Text(
            name,
            style: _smallWordStyle(fontSize: 14, color: Colors.grey[700]), 
          ),
          InkWell(
            onTap: () async {
              final uri = Uri.parse('mailto:$email');
              if (await canLaunchUrl(uri)) await launchUrl(uri);
            },
            child: Text(
              email,
              style: _smallWordStyle(fontSize: 14, color: const Color(0xFF001F3F)).copyWith(
                decoration: TextDecoration.underline,
              ),  
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
            height: 200,
            width: 400,
            child: Image.asset(
              'assets/petrobots logo.png',
              color: Colors.white,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  Text('PETROBOTS', style: _bigWordStyle(fontSize: 24, color: Colors.white)), 
            ),
          ),
          const SizedBox(height: 16),
          // Social icons placeholder
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                final uri = Uri.parse('https://www.instagram.com/petrobotsmakerfair.utp?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw==      ');
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
                  final uri = Uri.parse('https://www.linkedin.com/company/utp-petrobots/posts/?feedView=all      ');
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
          Text(
            'PETROBOTS Maker Fair 2026',
            style: _bigWordStyle(fontSize: 18, color: Colors.white70), 
          ),
          const SizedBox(height: 8),
          Text(
            'Universiti Teknologi PETRONAS (UTP), 32610 Seri Iskandar, Perak, Malaysia',
            style: _smallWordStyle(fontSize: 12, color: Colors.white), 
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'This event is organized by UTP PETROBOTS Student Society (UTP PETROBOTS)',
            style: _smallWordStyle(fontSize: 10, color: Colors.white30),
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
        title: Text('Search', style: _bigWordStyle(fontSize: 24)), 
        content: TextField(
          textInputAction: TextInputAction.search,
          controller: searching,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search: about, support, contact, category, registration, faq',
            prefixIcon: Icon( Icons.search),
            border: OutlineInputBorder(),
          ),
          textCapitalization: TextCapitalization.none,
          onSubmitted: (query) {
          FocusScope.of(context).unfocus();
          final cleanQuery = query.trim().replaceAll('\n', '');
          if (cleanQuery.isNotEmpty){
              _searchquery(context, cleanQuery, searching);
            }
          },
        ),
        actions: [
        TextButton(
          onPressed: () {
            searching.clear();
            Navigator.pop(context);
          },
          child: Text('Cancel', style: _smallWordStyle(fontSize: 14)),
        ),
        ElevatedButton(
          onPressed: () {
            final query = searching.text.trim();
            _searchquery(context, query, searching);
          },
          child: Text('Search', style: _smallWordStyle(fontSize: 14, color: Colors.white)),
        ),
      ],
      ),
    ).then((_) {searching.dispose();});
  }

  void _searchquery(BuildContext context, String query, TextEditingController searching) {
  if (!context.mounted) return;
  
  final lowerQuery = query.toLowerCase().trim();

  if (['about', 'support', 'contact'].contains(lowerQuery)) {
    Navigator.pop(context);  // Close dialog first
    
    if (_scrollToSection(context, lowerQuery)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('🔍 Scrolled to "$lowerQuery" section', style: _smallWordStyle(color: Colors.white)), 
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('⚠️ Could not scroll to "$lowerQuery" section', style: _smallWordStyle(color: Colors.white)), 
          backgroundColor: Colors.amber,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  } 
  else if (['category', 'registration', 'faq', 'competition'].contains(lowerQuery)) {
    Navigator.pop(context);  // Close search dialog
    
    if (['category', 'registration', 'faq'].contains(lowerQuery)) {
      if (_scrollToSection(context, lowerQuery)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('🔍 Scrolled to "$lowerQuery" section', style: _smallWordStyle(color: Colors.white)), 
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('🔍 Navigating to CompetitionPage for "$lowerQuery"...', style: _smallWordStyle(color: Colors.white)),  
            duration: const Duration(seconds: 2),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CompetitionPage(initialSection: lowerQuery),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('🔍 Navigating to CompetitionPage...', style: _smallWordStyle(color: Colors.white)), 
          duration: const Duration(seconds: 2),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CompetitionPage(initialSection: null),
        ),
      );
    }
  } 
  else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('⚠️ No results found for "$query"', style: _smallWordStyle(color: Colors.white)), 
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
        SnackBar(
          content: Text('Returned to HomePage top', style: _smallWordStyle(color: Colors.white)), 
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          ),
      );
    });
  }
}