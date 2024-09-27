part of 'widgets.dart';

class DashLine extends StatelessWidget {
  final double ketebalan;
  final Color warna;
  final double jarakAntarGaris;
  final double panjangGaris;
  DashLine({required this.ketebalan, required this.warna, required this.jarakAntarGaris, required this.panjangGaris});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, 1), // Ukuran garis (lebar x tinggi)
      painter: DashedLinePainter(ketebalan, warna, jarakAntarGaris, panjangGaris),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final double ketebalan;
  final Color warna;
  final double jarakAntarGaris;
  final double panjangGaris;
  DashedLinePainter(this.ketebalan, this.warna, this.jarakAntarGaris, this.panjangGaris);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = warna // Warna garis
      ..strokeWidth = ketebalan; // Ketebalan garis

    final dashWidth = panjangGaris; // Panjang satu segmen garis
    final dashSpace = jarakAntarGaris; // Jarak antara segmen garis
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
