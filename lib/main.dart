import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';

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
      home: HomePage(),
    );
  }
}

class MakerFairbar extends StatelessWidget {
  final Function(String)? onNavigate;
  final VoidCallback? onSearch; 
  final Widget title;
  const MakerFairbar({super.key, required this.title, this.onNavigate, this.onSearch});

  @override
  Widget build(BuildContext context) {    
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Color(0xFF001F3F), // Navy 
        boxShadow: [],
      ),
      child: Row( 
        children: [
          InkWell(onTap: (){}, 
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
                  onPressed: () => onNavigate?.call('about'),
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
                    onTitle: () => onNavigate?.call('support'),
                    items: [
                      DropdownItem (
                        label: 'MAKE A CONTRIBUTION',
                        url: null, //next time
                        onTapOverride: () => onNavigate?.call('support'),
                      ),
                      
                      DropdownItem(
                        label:'BECOME OUR SPONSOR',
                        url: null, //next time
                        onTapOverride: () => onNavigate?.call('support'),
                      ),
                      
                    ],// Add functionality for title button
                  ),
                const SizedBox(width: 20),

                NavigateDropdown(
                    title: 'COMPETITION',
                    width: 200,
                    textStyle: const TextStyle(color: Colors.white, fontSize: 20),
                    onTitle: ()  => onNavigate?.call('competition'),
                    items: [
                      DropdownItem (
                        label: 'CATEGORIES',
                        url: null,
                        onTapOverride: () => onNavigate?.call('category'),
                      ),
                      
                      DropdownItem(
                        label:'JOIN ROBOTRACK GP',
                        url: null,
                        onTapOverride: () => onNavigate?.call('registration'),
                      ),
                      DropdownItem(
                        label:'FAQs',
                        url: null,
                        onTapOverride: () => onNavigate?.call('faq'),
                      )
                    ],// Add functionality for title button
                  ),
                const SizedBox(width: 20),

                TextButton(
                  onPressed: () => onNavigate?.call('contact'),
                  style: TextButton.styleFrom(
                    overlayColor: Colors.transparent,
                  ),
                  child: const Text('CONTACT', style: TextStyle(color:Colors.white, fontSize: 20)),// Add functionality for title button
                ),
              ],
            )
          ),
          IconButton(
            icon: Icon(Icons.search, size: 40, color: Colors.white),
            onPressed: onSearch,
             // Add functionality for account button
          ),
        ]
      )
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

