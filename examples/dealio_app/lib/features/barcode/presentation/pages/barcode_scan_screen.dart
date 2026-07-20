import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:untitled5/core/common_widgets/error_banner.dart';
import 'package:untitled5/core/responsive/responsive_layout.dart';
import 'package:untitled5/core/theme/app_colors.dart';
import 'package:untitled5/core/utils/plan_guard.dart';
import 'package:untitled5/features/barcode/presentation/providers/barcode_provider.dart';
import 'package:untitled5/features/barcode/presentation/widgets/barcode_result_view.dart';
import 'package:untitled5/features/billing/presentation/widgets/paywall_widget.dart';

class BarcodeScanScreen extends ConsumerStatefulWidget {
  const BarcodeScanScreen({super.key});

  @override
  ConsumerState<BarcodeScanScreen> createState() => _BarcodeScanScreenState();
}

class _BarcodeScanScreenState extends ConsumerState<BarcodeScanScreen> {
  final MobileScannerController _controller = MobileScannerController();
  bool _isScanned = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final barcodeState = ref.watch(barcodeProvider);
    final theme = Theme.of(context);
    final planGuard = ref.watch(planGuardProvider);

    if (!planGuard.canScanBarcode) {
      return _buildLockedState(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Barcode'),
        actions: [
          ValueListenableBuilder<MobileScannerState>(
            valueListenable: _controller,
            builder: (context, state, child) {
              final torchState = state.torchState;
              return IconButton(
                icon: Icon(
                  torchState == TorchState.on
                      ? Iconsax.flash_1
                      : Iconsax.flash_1,
                  color: torchState == TorchState.on
                      ? Colors.yellow
                      : Colors.grey,
                ),
                onPressed: () => _controller.toggleTorch(),
              );
            },
          ),
          ValueListenableBuilder<MobileScannerState>(
            valueListenable: _controller,
            builder: (context, state, child) {
              return IconButton(
                icon: const Icon(Iconsax.camera),
                onPressed: () => _controller.switchCamera(),
              );
            },
          ),
        ],
      ),
      body:
          barcodeState.status == BarcodeStatus.success ||
              barcodeState.status == BarcodeStatus.emptyNotFound
          ? ResponsivePageFrame(
              child: SingleChildScrollView(
                padding: context.responsivePagePadding(top: 24),
                child: barcodeState.status == BarcodeStatus.emptyNotFound
                    ? _buildNotFound(theme)
                    : BarcodeResultView(
                        result: barcodeState.result!,
                        onScanAgain: () {
                          setState(() => _isScanned = false);
                          ref.read(barcodeProvider.notifier).reset();
                        },
                        onUseForSearch: (query) {
                          if (query.trim().isEmpty) return;
                          Navigator.of(context).pop(query.trim());
                        },
                      ),
              ),
            )
          : Stack(
              children: [
                MobileScanner(
                  controller: _controller,
                  onDetect: (capture) {
                    if (_isScanned) return;
                    final List<Barcode> barcodes = capture.barcodes;
                    if (barcodes.isNotEmpty) {
                      final barcode = barcodes.first;
                      if (barcode.rawValue != null) {
                        setState(() => _isScanned = true);
                        ref
                            .read(barcodeProvider.notifier)
                            .handleBarcodeScanned(
                              barcode.rawValue!,
                              barcode.format.name,
                            );
                      }
                    }
                  },
                ),
                _buildOverlay(theme),
                if (barcodeState.status == BarcodeStatus.processing)
                  Container(
                    color: Colors.black54,
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(color: Colors.white),
                          SizedBox(height: 16),
                          Text(
                            'Processing Barcode...',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (barcodeState.status == BarcodeStatus.error)
                  Positioned(
                    bottom: 40,
                    left: 20,
                    right: 20,
                    child: ErrorBanner(
                      message: barcodeState.errorMessage ?? 'Unknown error',
                      onRetry: () {
                        setState(() => _isScanned = false);
                        ref.read(barcodeProvider.notifier).reset();
                      },
                    ),
                  ),
              ],
            ),
    );
  }

  Widget _buildLockedState(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Barcode')),
      body: ResponsiveContent(
        maxWidth: 460,
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Iconsax.lock, size: 64, color: AppColors.textTertiary),
              const SizedBox(height: 24),
              const Text(
                'Barcode Scanning is for PRO Users',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Unlock the ability to find products instantly by scanning their barcodes.',
                style: TextStyle(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => PaywallDialog.show(
                  context,
                  title: 'Upgrade to PRO',
                  message: 'Get unlimited barcode scans and more!',
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  backgroundColor: AppColors.cobalt,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Unlock Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverlay(ThemeData theme) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double scanArea = constraints.maxWidth * 0.7;
        return Stack(
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withValues(alpha: 0.5),
                BlendMode.srcOut,
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      backgroundBlendMode: BlendMode.dstOut,
                    ),
                  ),
                  Center(
                    child: Container(
                      height: scanArea,
                      width: scanArea,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                height: scanArea,
                width: scanArea,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.cobalt, width: 4),
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Text(
                'Center the barcode within the frame',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildNotFound(ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 60),
        const Icon(Iconsax.search_status, size: 80, color: Colors.orange),
        const SizedBox(height: 24),
        Text(
          'Product Not Found',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'We couldn\'t find a product linked to this barcode in our database.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
        ),
        const SizedBox(height: 48),
        ElevatedButton(
          onPressed: () {
            setState(() => _isScanned = false);
            ref.read(barcodeProvider.notifier).reset();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.cobalt,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            'Try Again',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
