import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'competition_page.dart';

void main(){
  runApp(const MakerFairWeb());
}

class MakerFairWeb extends StatelessWidget {
  const MakerFairWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PETROBOTS Maker Fair 2026',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF001F3F), // Navy Blue
        brightness: Brightness.light,
        ),
        fontFamily:'Bitcount Grid Double',
      ),
      home: const MyScaffold(),
    );
  }
}

class MakerFairbar extends StatelessWidget {
  const MakerFairbar({required this.title, super.key});

  final Widget title;

  @override
  Widget build(BuildContext context) {    
    return Container(
      height : 100,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xFF001F3F), // Navy Blue
        boxShadow: [],
      ),
      child: Row(
        children: [
          InkWell(onTap: (){
            //Next time
          }, 
          borderRadius: BorderRadius.circular(8),
          splashColor: Colors.white24,
          highlightColor: Colors.white12,
          child:
            Padding(padding: EdgeInsets.symmetric(horizontal: 4),
            child: SizedBox(
              height: 90,
              width: 200,
              child: Image.asset('assets/petrobots logo.png', fit: BoxFit.cover,color: Colors.white),
             )
            ), 
          ),

          const SizedBox(width: 10),

          Expanded(
            child :Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: (){},
                  style: TextButton.styleFrom(
                    overlayColor: Colors.transparent,
                  ),
                  child: const Text('ABOUT PMF', style: TextStyle(color:Colors.white, fontSize: 20)),// Add functionality for title button
                ),
                const SizedBox(width:20),
              
                NavigateDropdown(
                    title: 'SUPPORT US',
                    width: 200,
                    textStyle: const TextStyle(color: Colors.white, fontSize: 20),
                    items: const [
                      DropdownItem (
                        label: 'MAKE A CONTRIBUTION',
                        url: null, //next time
                      ),
                      
                      DropdownItem(
                        label:'BECOME OUR SPONSOR',
                        url: null, //next time
                      ),
                    ],// Add functionality for title button
                  ),
                const SizedBox(width: 20),

                NavigateDropdown(
                    title: 'COMPETITION',
                    width: 200,
                    textStyle: const TextStyle(color: Colors.white, fontSize: 20),
                    onTitle: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => CompetitionPage(initialSection: null)
                          ),
                      );
                    },
                    items: [
                      DropdownItem (
                        label: 'CATEGORIES',
                        url: null,
                        onTapOverride: (){
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => CompetitionPage(initialSection: 'category',)
                              ),
                          );
                        }
                      ),
                      
                      DropdownItem(
                        label:'JOIN ROBOTRACK GP',
                        url: null,
                        onTapOverride: (){
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => CompetitionPage(initialSection: 'registration',)
                              ),
                          );
                        }
                      ),
                      DropdownItem(
                        label:'FAQs',
                        url: null,
                        onTapOverride: (){
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => CompetitionPage(initialSection: 'faq',)
                              ),
                          );
                        }
                      )
                    ],// Add functionality for title button
                  ),
                const SizedBox(width: 20),

                TextButton(
                  onPressed: (){},
                  style: TextButton.styleFrom(
                    overlayColor: Colors.transparent,
                  ),
                  child: const Text('CONTACT', style: TextStyle(color:Colors.white, fontSize: 20)),// Add functionality for title button
                ),
              ],
            )
          ),
          const IconButton(
            icon: Icon(Icons.search, size: 40, color: Colors.white),
            onPressed: null, // Add functionality for account button
          ),
        ]
      )
    );
  }
}

class MyScaffold extends StatelessWidget {
  const MyScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: MakerFairbar(
          title: const Text(
            'PETROBOTS Maker Fair 2026',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
      
      
      body:   
        Container(
          color: Colors.white,
          child: Column(children: [
            Container(height: 4, color: Colors.amber),
          ],)),
    );
  }
}

class NavigateDropdown extends StatefulWidget {
  final String title;
  final List<DropdownItem> items;
  final TextStyle? textStyle;
  final double? width;
  final VoidCallback? onTitle;

  const NavigateDropdown({
    super.key,
    required this.title, 
    required this.items, 
    this.textStyle,
    this.width,
    this.onTitle,
    });

  @override
  State<NavigateDropdown> createState() => _NavigateDropdownState();
}

class DropdownItem {
  final String label;
  final String? url; 
  final VoidCallback? onTapOverride;

  const DropdownItem({required this.label, this.url, this.onTapOverride});
  
}

class _NavigateDropdownState extends State<NavigateDropdown> {
  // ignore: unused_field
  final _overlayController = OverlayPortalController();
  final _linkHold = LayerLink();

  Timer? _closeTimer;

  
  void _showMenu() {
    _closeTimer?.cancel();
    _overlayController.show();
  }
  void _hideMenu() {
    _closeTimer = Timer(const Duration(milliseconds: 100), () {
      _overlayController.hide();
    });
  }
  @override
  void dispose() {
    _closeTimer?.cancel();
    super.dispose();
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
        );
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _showMenu(),
      onExit: (_) => _hideMenu(),
      child: CompositedTransformTarget(
        link: _linkHold,
        child: OverlayPortal(
          controller: _overlayController,
          overlayChildBuilder: (context) => _buildMenu(),
          child: TextButton(
            onPressed: widget.onTitle,
            style: TextButton.styleFrom(
              overlayColor: Colors.transparent,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title,
                  style: widget.textStyle ??
                    const TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(width: 4),
                Icon(Icons.arrow_drop_down, color: Colors.white, size: 24),
              ],
            )
          ),
        ),
      ),
    );
  }

  Widget _buildMenu() {
    return CompositedTransformFollower(
      link: _linkHold,
      showWhenUnlinked: false,
      offset: const Offset(0, 40),
      child: Align(
        alignment: Alignment.topLeft,
        child: MouseRegion(
          onEnter: (_) => _showMenu(),
          onExit: (_) => _hideMenu(),
          child: Container(
            width: widget.width ?? 200,
            decoration: BoxDecoration(
              color: const Color(0xFF001F3F), // Navy Blue
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.items.map((item) => _buildMenuItem(item)).toList(),
            ),
          ),
      ),
    ),
  );
}

Widget _buildMenuItem(DropdownItem item){
  return InkWell(
    onTap: () async {
        _closeTimer?.cancel();
        _overlayController.hide();


        if (item.onTapOverride != null) {
          item.onTapOverride!();
        } else if (item.url != null) {
            await _launchURL(item.url!);
          } 
          else {
            print('${item.label} tapped');
          }
      },

    hoverColor: Colors.white12,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      alignment: Alignment.centerLeft,
      child: Text(item.label, style: widget.textStyle ??
        const TextStyle(color: Colors.white, fontSize: 16),
        ),
     ),
  );
  }
}

