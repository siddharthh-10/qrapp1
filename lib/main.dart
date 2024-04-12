//import 'dart:math';
//import 'dart:typed_data';
//import 'dart:ui' as ui;
//import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
  addDummyCertificateData(); // Call function to populate data
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Certificate Verification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Certificate Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Verification',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ManualVerificationPage(),
                  ),
                );
                // Navigate to manual verification page
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.description, size: 36),
                    SizedBox(width: 16),
                    Text(
                      'Manual Verification',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QRScannerPage(),
                  ),
                );
                // Navigate to QR scan page
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.qr_code_scanner, size: 36),
                    SizedBox(width: 16),
                    Text(
                      'Scan QR Code',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Government Officials Login',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GovernmentLoginScreen(),
                  ),
                );
                // Navigate to government officials login page
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.security, size: 36),
                    SizedBox(width: 16),
                    Text(
                      'Login',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CaptchaWidget extends StatelessWidget {
  const CaptchaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Captcha Verification'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the next page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          child: Text('Verify'),
        ),
      ),
    );
  }
}

class VerificationOptions extends StatelessWidget {
  const VerificationOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verification Options'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to manual verification page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ManualVerificationPage()),
                );
              },
              child: Text('Manual Verification'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to QR scanner page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QRScannerPage()),
                );
              },
              child: Text('Scan QR Code'),
            ),
          ],
        ),
      ),
    );
  }
}

class ManualVerificationPage extends StatefulWidget {
  @override
  _ManualVerificationPageState createState() => _ManualVerificationPageState();
}

class _ManualVerificationPageState extends State<ManualVerificationPage> {
  final TextEditingController certificateNumberController =
      TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController issueDateController = TextEditingController();

  bool showError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manual Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Certificate Number'),
              controller: certificateNumberController,
            ),
            SizedBox(height: 16),
            _buildDropdownField(context, 'State', [
              'Andhra Pradesh',
              'Assam',
              'Bihar',
              'Goa',
              'Gujarat',
              'Haryana',
              'Himachal Pradesh',
              'Jharkhand',
              'Karnataka',
              'Kerala',
              'Madhya Pradesh',
              'Maharashtra',
              'Manipur',
              'Meghalaya',
              'Mizoram',
              'Nagaland',
              'Odisha',
              'Punjab',
              'Rajasthan',
              'Sikkim',
              'Tamil Nadu',
              'Telangana',
              'Tripura',
              'Uttar Pradesh',
              'Uttarakhand',
              'West Bengal'
            ]),
            SizedBox(height: 16),
            _buildDateField(context, 'Issue Date'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                bool detailsMatch = await searchFirestore(
                  certificateNumber: certificateNumberController.text,
                  state: stateController.text,
                  issueDate: issueDateController.text,
                );
                if (detailsMatch) {
                  // If details match, navigate to CertificateDetailsFormPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CertificateDetailsFormPage(
                        certificateNumber: certificateNumberController.text,
                        state: stateController.text,
                        issueDate: issueDateController.text,
                      ),
                    ),
                  );
                } else {
                  // If details do not match, display an error message
                  setState(() {
                    showError = true;
                  });
                }
              },
              child: Text('Verify'),
            ),
            if (showError)
              Text(
                'Entered details do not match with any existing certificate',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField(
      BuildContext context, String label, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            // Add logic to handle state selection
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDateField(BuildContext context, String label) {
    DateTime? selectedDate;
    TextEditingController dateController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 8),
        TextFormField(
          controller: dateController,
          readOnly: true,
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (picked != null && picked != selectedDate) {
              selectedDate = picked;
              dateController.text = picked.toString();
            }
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

class Certificate {
  final String certificateNumber;
  final String state;
  final String issueDate;
  // Add other fields as needed

  Certificate({
    required this.certificateNumber,
    required this.state,
    required this.issueDate,
  });
}

void addDummyCertificateData() async {
  CollectionReference certificates =
      FirebaseFirestore.instance.collection('certificates');

  // Dummy data
  List<Certificate> dummyCertificates = [
    Certificate(
        certificateNumber: 'CERT001',
        state: 'Telangana',
        issueDate: '2024-03-18'),
    Certificate(
        certificateNumber: 'CERT002',
        state: 'Maharashtra',
        issueDate: '2024-03-19'),
    Certificate(
        certificateNumber: 'CERT003',
        state: 'Tamil Nadu',
        issueDate: '2024-03-21'),
    Certificate(
        certificateNumber: 'CERT004',
        state: 'Karnataka',
        issueDate: '2024-03-24'),
    Certificate(
        certificateNumber: 'CERT005', state: 'Kerala', issueDate: '2024-03-26'),
    Certificate(
        certificateNumber: 'CERT006', state: 'Gujarat', issueDate: '2024-03-27')
    // Add more dummy certificates as needed
  ];

  for (Certificate cert in dummyCertificates) {
    await certificates.add({
      'certificateNumber': cert.certificateNumber,
      'state': cert.state,
      'issueDate': cert.issueDate,

      // Add other fields as needed
    });
  }
}

Future<bool> searchFirestore({
  required String certificateNumber,
  required String state,
  required String issueDate,
}) async {
  try {
    // Reference to the certificates collection
    CollectionReference certificatesRef =
        FirebaseFirestore.instance.collection('certificates');

    // Construct the query based on the entered parameters
    QuerySnapshot querySnapshot = await certificatesRef
        .where('certificateNumber', isEqualTo: certificateNumber)
        .where('state', isEqualTo: state)
        .where('issueDate', isEqualTo: issueDate)
        .get();

    // Check if any documents match the query
    return querySnapshot.docs.isNotEmpty;
  } catch (e) {
    // Handle any errors that occur during the query
    print('Error searching Firestore: $e');
    return false;
  }
}

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({Key? key}) : super(key: key);

  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? _controller;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanning'),
      ),
      body: Stack(
        children: [
          QRView(
            key: _qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CertificateDetailsFormPage(),
                    ),
                  );
                },
                child: Text('Scan'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      // Add your logic for handling scanned QR code data here
    });
  }
}

class CertificateDetailsFormPage extends StatelessWidget {
  const CertificateDetailsFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Certificate Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Verify Certificate',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              _buildCertificateDetailTextField('Certificate Number', '123456'),
              _buildCertificateDetailTextField('Issue Date', '2022-02-18'),
              _buildCertificateDetailTextField('Acc. Reference', 'ABC123'),
              _buildCertificateDetailTextField(
                  'Unique Doc. Reference', 'X1Y2Z3'),
              _buildCertificateDetailTextField('Purchased By', 'ubhcjd'),
              _buildCertificateDetailTextField(
                  'Description of Document', 'nexcwgvc'),
              _buildCertificateDetailTextField(
                  'Property Description', 'hjcnwiofuv'),
              _buildCertificateDetailTextField('Consideration Price', '6842'),
              _buildCertificateDetailTextField('First Party', 'dhkdc'),
              _buildCertificateDetailTextField('Second Party', 'udhyj'),
              _buildCertificateDetailTextField('Stamp Duty Paid By', 'refgvxb'),
              _buildCertificateDetailTextField('Stamp Duty Amount', '68736'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCertificateDetailTextField(String label, String initialValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

class GovernmentLoginScreen extends StatelessWidget {
  const GovernmentLoginScreen({Key? key}) : super(key: key);

  // Function to handle the login button pressed
  void _handleLogin(BuildContext context) {
    // Perform validation here (e.g., check if username and password are not empty)
    // For simplicity, let's assume the login is successful
    // Replace this with your actual authentication logic

    // Navigate to the home page after successful login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              GovernmentOptionsPage()), // Navigate to the home page or wherever you want to go
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Government Login'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person), // Add the user icon
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _handleLogin(context); // Call the login handler function
              },
              child: Text('Login'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Add logic to handle forgot password
              },
              child: Text('Forgot Password?'),
            ),
          ],
        ),
      ),
    );
  }
}

class GovernmentOptionsPage extends StatelessWidget {
  const GovernmentOptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Government Options'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // Navigate to the screen for locking certificates
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LockCertificatePage(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.lock,
                      size: 48,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Lock Certificates',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Navigate to the screen for viewing locked certificates
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewLockedCertificatesPage(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.visibility,
                      size: 48,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'View Locked Certificates',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LockCertificatePage extends StatelessWidget {
  const LockCertificatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lock Certificates'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to the screen for manually entering certificate details
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ManualLockCertificatePage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                textStyle: TextStyle(fontSize: 20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.edit,
                    size: 48,
                    color: Color.fromARGB(255, 91, 1, 139),
                  ),
                  SizedBox(width: 10),
                  Text('Manually Enter Certificate Details',
                      style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the screen for scanning QR code
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScanLockCertificatePage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                textStyle: TextStyle(fontSize: 20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.qr_code_scanner,
                    size: 48,
                    color: Color.fromARGB(255, 91, 1, 139),
                  ),
                  SizedBox(width: 10),
                  Text('Scan QR Code', style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewLockedCertificatesPage extends StatelessWidget {
  const ViewLockedCertificatesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Locked Certificates'),
      ),
      body: ListView.builder(
        itemCount: lockedCertificates.length,
        itemBuilder: (context, index) {
          final certificate = lockedCertificates[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Certificate Number: ${certificate.certificateNumber}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('First Part: ${certificate.firstPart}'),
                    Text('Stamp Duty: ${certificate.stampDuty}'),
                    Text(
                        'Registration Number: ${certificate.registrationNumber}'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Dummy data for testing purposes
final List<LockedCertificate> lockedCertificates = [
  LockedCertificate('12345', 'ABC', 'StampDuty1', 'RegNo1'),
  LockedCertificate('67890', 'XYZ', 'StampDuty2', 'RegNo2'),
  LockedCertificate('86359', 'PQR', 'StampDuty3', 'RegNo3'),
  LockedCertificate('36742', 'ISB', 'StampDuty4', 'RegNo4'),
];

// Model class for locked certificates
class LockedCertificate {
  final String certificateNumber;
  final String firstPart;
  final String stampDuty;
  final String registrationNumber;

  LockedCertificate(
    this.certificateNumber,
    this.firstPart,
    this.stampDuty,
    this.registrationNumber,
  );
}

class ManualLockCertificatePage extends StatefulWidget {
  const ManualLockCertificatePage({Key? key}) : super(key: key);

  @override
  _ManualLockCertificatePageState createState() =>
      _ManualLockCertificatePageState();
}

class _ManualLockCertificatePageState extends State<ManualLockCertificatePage> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Certificate Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Certificate Number'),
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Issue Date',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(
                  '${_selectedDate.day}-${_selectedDate.month}-${_selectedDate.year}',
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to the CertificateDetailsPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CertificateDetailsPage(
                        certificateNumber: 'IN-TS0055564837487374783R',
                        issueDate: '11-Dec-2020 4:30 PM',
                        accReference: 'NONACC(FI)/testings/MAHAPE/MH-PU',
                        propertyDescription: 'Ravi',
                        considerationPrice: '0 (Zero)',
                        firstParty: 'Ravi',
                        secondParty: 'Ravi',
                        stampDutyPaidBy: 'Ravi',
                        stampDuty: '1,000 (One Thousand only)'
                        // Add other required parameters here
                        ),
                  ),
                );
              },
              child: Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}

class ScanLockCertificatePage extends StatefulWidget {
  const ScanLockCertificatePage({Key? key}) : super(key: key);

  @override
  _ScanLockCertificatePageState createState() =>
      _ScanLockCertificatePageState();
}

class _ScanLockCertificatePageState extends State<ScanLockCertificatePage> {
  final GlobalKey _qrKey = GlobalKey();
  late QRViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: QRView(
              key: _qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the CertificateDetailsPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CertificateDetailsPage(
                          certificateNumber: 'IN-TS0055564837487374783R',
                          issueDate: '11-Dec-2020 4:30 PM',
                          accReference: 'NONACC(FI)/testings/MAHAPE/MH-PU',
                          propertyDescription: 'Ravi',
                          considerationPrice: '0 (Zero)',
                          firstParty: 'Ravi',
                          secondParty: 'Ravi',
                          stampDutyPaidBy: 'Ravi',
                          stampDuty: '1,000 (One Thousand only)'
                          // Pass other parameters as needed
                          ),
                    ),
                  );
                },
                child: Text('Scan'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
    });
    _controller.scannedDataStream.listen((scanData) {
      // Handle scanned QR code data here
      // You can add logic to process the scanned data if needed
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CertificateDetailsPage extends StatelessWidget {
  const CertificateDetailsPage({
    Key? key,
    required this.certificateNumber,
    required this.issueDate,
    required this.accReference,
    required this.propertyDescription,
    required this.considerationPrice,
    required this.firstParty,
    required this.secondParty,
    required this.stampDutyPaidBy,
    required this.stampDuty,
  }) : super(key: key);

  final String certificateNumber;
  final String issueDate;
  final String accReference;
  final String propertyDescription;
  final String considerationPrice;
  final String firstParty;
  final String secondParty;
  final String stampDutyPaidBy;
  final String stampDuty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Certificate Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextField('Certificate Number', certificateNumber),
              buildTextField('Issue Date', issueDate),
              buildTextField('Acc. Reference', accReference),
              buildTextField('Property Description', propertyDescription),
              buildTextField('Consideration Price', considerationPrice),
              buildTextField('First Party', firstParty),
              buildTextField('Second Party', secondParty),
              buildTextField('Stamp Duty Paid By', stampDutyPaidBy),
              buildTextField('Stamp Duty', stampDuty),
              // Add more details as needed...

              // Add the section for entering registration number and locking certificate
              SizedBox(height: 32.0),
              Text(
                'Enter Registration Number:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                  // Add your text field properties here
                  ),

              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Show dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Certificate Locked Successfully'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close dialog
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Lock Certificate'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        SizedBox(height: 4),
        TextFormField(
          initialValue: value,
          readOnly: true,
          style: TextStyle(fontSize: 16),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

class LockCertificateScreen extends StatelessWidget {
  const LockCertificateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lock Certificate'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Show dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Certificate Locked Successfully'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close dialog
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          },
          child: Text('Lock Certificate'),
        ),
      ),
    );
  }
}

//UI changes

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;

  const MyAppBar({
    Key? key,
    required this.title,
    this.showBackButton = false,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: showBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : null,
      actions: [
        IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      ],
    );
  }
}
