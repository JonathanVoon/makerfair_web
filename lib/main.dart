import 'package:flutter/material.dart';

void main(){
  runApp(const MakerFairWeb());
}

class MakerFairWeb extends StatelessWidget {
  const MakerFairWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                    title: 'JOIN & SUPPORT',
                    width: 200,
                    textStyle: const TextStyle(color: Colors.white, fontSize: 20),
                    items: const ['JOIN THE COMPETITION', 'SUPPORT US',],// Add functionality for title button
                  ),
                const SizedBox(width: 20),

                TextButton(
                  onPressed: (){},
                  style: TextButton.styleFrom(
                    overlayColor: Colors.transparent,
                  ),
                  child: const Text('COMPETITION', style: TextStyle(color:Colors.white, fontSize: 20)),// Add functionality for title button
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
  final List<String> items;
  final TextStyle? textStyle;
  final double? width;

  const NavigateDropdown({
    super.key,
    required this.title, 
    required this.items, 
    this.textStyle,
    this.width,
    });

  @override
  State<NavigateDropdown> createState() => _NavigateDropdownState();
}

class _NavigateDropdownState extends State<NavigateDropdown> {
  // ignore: unused_field
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          TextButton(
            onPressed: (){},
            style: TextButton.styleFrom(
              overlayColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 8),
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

          if (_isHovered)
            Positioned(top: 35, left: 0, child:
              MouseRegion(
                onEnter: (_) => setState(() => _isHovered = true),
                onExit: (_) => setState(() => _isHovered = false),
                child: Container(
                  width: widget.width ?? 200,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color (0xFF001F3F), // Navy Blue
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.items.map((item) {
                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          print('$item tapped');
                        },
                        hoverColor: Colors.transparent,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          alignment: Alignment.centerLeft,
                          child: Text(item, style: const TextStyle(color: Colors.white)),
                        ),
                      ),
                    );
                  }
                  ).toList(),
                ),
              ),
            ),
          ),
        ],
        
      ),
    );
  }
}