import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ProductBackgroundScreen extends StatelessWidget {
  const ProductBackgroundScreen({super.key});

  static const double kIconButtonSize = 44;
  static const double kInnerIconSize = 44;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF0F1926),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 12),
            _HeaderBar(),
            SizedBox(height: 16),
            _ThreeDShowcase(),
            Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}

class _HeaderBar extends StatelessWidget {
  const _HeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 335,
        height: ProductBackgroundScreen.kIconButtonSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Center(
              child: Text(
                "NFT",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: _IconBtnPlain(asset: 'assets/icons/Icon.png'),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: _IconBtnPlain(asset: 'assets/icons/Group.png'),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconBtnPlain extends StatelessWidget {
  final String asset;
  final VoidCallback? onTap;
  const _IconBtnPlain({super.key, required this.asset, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ProductBackgroundScreen.kIconButtonSize,
      height: ProductBackgroundScreen.kIconButtonSize,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(
            ProductBackgroundScreen.kIconButtonSize / 2,
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Center(
            child: SizedBox(
              width: ProductBackgroundScreen.kInnerIconSize,
              height: ProductBackgroundScreen.kInnerIconSize,
              child: Image.asset(
                asset,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ThreeDShowcase extends StatefulWidget {
  const _ThreeDShowcase({super.key});

  @override
  State<_ThreeDShowcase> createState() => _ThreeDShowcaseState();
}

enum _ModelId { astronaut, helmet }

class _ThreeDShowcaseState extends State<_ThreeDShowcase> {
  static const double viewerW = 335;
  static const double viewerH = 300;

  static const double ringW = 311;
  static const double ringH = 65;
  static const double ringBottom = 0;

  _ModelId _selected = _ModelId.astronaut;

  // مسیر صحیح مدل برای وب و غیر وب
  String _assetPath(String relative) => kIsWeb ? 'assets/$relative' : relative;

  String get _glbSrc {
    switch (_selected) {
      case _ModelId.astronaut:
        return _assetPath('assets/models/Astronaut.glb');
      case _ModelId.helmet:
        return _assetPath('assets/models/stylize_helmet.glb');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: SizedBox(
            width: viewerW,
            height: viewerH + ringH / 2,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      color: const Color(0xFF0F1926),
                      child: ModelViewer(
                        key: ValueKey(_glbSrc), // برای ریلود هنگام تغییر مدل
                        src: _glbSrc,
                        alt: '3D Model',
                        ar: true,
                        arPlacement: ArPlacement.floor,
                        arScale: ArScale.fixed,
                        cameraControls: true,
                        autoRotate: true,
                        autoRotateDelay: 0,
                        disableZoom: false,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: (viewerW - ringW) / 2,
                  bottom: ringBottom + ringH * 0.25, // کمی پشت حلقه
                  child: IgnorePointer(
                    child: Container(
                      width: ringW,
                      height: 120,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            const Color(0xFF2E6BD9).withOpacity(0.18),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: (viewerW - ringW) / 2,
                  bottom: ringBottom,
                  child: IgnorePointer(
                    child: SizedBox(
                      width: ringW,
                      height: ringH,
                      child: Image.asset(
                        'assets/images/Group1.png',
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Own the digital twin. Buy the NFT to unlock AR placement, high‑res textures, and a certificate of authenticity.",
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12.5,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        const SizedBox(height: 12),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Gallery',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        SizedBox(
          height: 74,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            children: [
              _ModelThumb(
                label: 'ASTRO',
                selected: _selected == _ModelId.astronaut,
                onTap: () => setState(() => _selected = _ModelId.astronaut),
              ),
              const SizedBox(width: 12),
              _ModelThumb(
                label: 'HELMET',
                selected: _selected == _ModelId.helmet,
                onTap: () => setState(() => _selected = _ModelId.helmet),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ModelThumb extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ModelThumb({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = selected
        ? Colors.white.withOpacity(0.10)
        : Colors.white.withOpacity(0.06);
    final border = selected ? const Color(0xFF4DA3FF) : Colors.transparent;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: border, width: 2),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: selected
                  ? const Color(0xFF4DA3FF)
                  : Colors.white.withOpacity(0.85),
              fontWeight: FontWeight.w700,
              fontSize: 12,
              letterSpacing: 0.6,
            ),
          ),
        ),
      ),
    );
  }
}
