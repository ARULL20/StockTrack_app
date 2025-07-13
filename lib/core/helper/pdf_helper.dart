import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class PDFHelper {
  static Future<File> generateLaporanPDF({
    required double pemasukan,
    required double pengeluaran,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Laporan StokTrack', style: pw.TextStyle(fontSize: 24)),
            pw.SizedBox(height: 20),
            pw.Text('Total Pemasukan: Rp ${pemasukan.toStringAsFixed(2)}'),
            pw.Text('Total Pengeluaran: Rp ${pengeluaran.toStringAsFixed(2)}'),
            pw.SizedBox(height: 20),
            pw.Text('Tanggal Cetak: ${DateTime.now()}'),
          ],
        ),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/laporan_stoktrack.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
