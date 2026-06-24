import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// class StudentInfoScreen extends StatefulWidget {
//   const StudentInfoScreen({super.key});

//   @override
//   State<StudentInfoScreen> createState() => _StudentInfoScreenState();
// }

// class _StudentInfoScreenState extends State<StudentInfoScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
// ဒီအပိုင်းတစ်ခုလုံးကို ဖြတ်ထုတ်ပြီး student_info page မှာ သွားထည့်ပေးရပါမယ်

class StudentRegisterScreen extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final String phone;

  const StudentRegisterScreen({
    super.key,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });

  @override
  State<StudentRegisterScreen> createState() => _StudentRegisterScreenState();
}

class _StudentRegisterScreenState extends State<StudentRegisterScreen> {
  String? selectedYearCode;
  String? selectedYearLevel;
  String? selectedSemester;

  final List<String> academicYears = [
    "(18-19)",
    "(19-20)",
    "(22-23)",
    "(22-23) J",
    "(23-24)",
    "(24-25)",
  ];
  final List<String> yearLevels = [
    "First Year",
    "Second Year",
    "Third Year",
    "Fourth Year",
    "Final Year",
  ];
  final List<String> semesters = [
    "I",
    "II",
    "III",
    "IV",
    "V",
    "VI",
    "VII",
    "VIII",
    "IX",
    "X",
  ];

  final _studentFormKey = GlobalKey<FormState>();
  final rollNumberController = TextEditingController();

  @override
  void dispose() {
    rollNumberController.dispose();
    super.dispose();
  }

  void completeRegistration() {
    if (_studentFormKey.currentState!.validate()) {
      String fullRollNo =
          "UCSTT-$selectedYearCode-${rollNumberController.text.trim()}";

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 30),
              SizedBox(width: 10),
              Text("Success", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          content: Text(
            "Hello ${widget.name},\nYour student account has been created successfully!\n\n"
            "Phone: ${widget.phone}\n"
            "Roll No: $fullRollNo\n"
            "Level: $selectedYearLevel\n"
            "Semester: $selectedSemester",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text(
                "OK",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = const Color(0xff0F7C90);

    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      appBar: AppBar(
        title: const Text(
          "Student Profile Setup",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _studentFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome, ${widget.name}! 👋",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: themeColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Complete your student profile information to finish registration.",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
                const SizedBox(height: 25),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.05),
                        spreadRadius: 5,
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Roll Number",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              readOnly: true,
                              initialValue: "UCSTT",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 5,
                            child: DropdownButtonFormField<String>(
                              value: selectedYearCode,
                              hint: const Center(
                                child: Text(
                                  "Aca Year",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              isExpanded: true,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              items: academicYears.map((String year) {
                                return DropdownMenuItem<String>(
                                  value: year,
                                  child: Center(
                                    child: Text(
                                      year,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) =>
                                  setState(() => selectedYearCode = value),
                              validator: (value) =>
                                  value == null ? "Required" : null,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 4,
                            child: TextFormField(
                              controller: rollNumberController,
                              keyboardType: TextInputType.number,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              style: const TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                hintText: "No.",
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              validator: (value) =>
                                  (value == null || value.trim().isEmpty)
                                  ? "Required"
                                  : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Year Level",
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                DropdownButtonFormField<String>(
                                  value: selectedYearLevel,
                                  hint: const Text(
                                    "Select Year",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  isExpanded: true,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.school_outlined,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                      horizontal: 10,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  items: yearLevels.map((String level) {
                                    return DropdownMenuItem<String>(
                                      value: level,
                                      child: Text(
                                        level,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) =>
                                      setState(() => selectedYearLevel = value),
                                  validator: (value) => value == null
                                      ? "Please select year"
                                      : null,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Semester",
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                DropdownButtonFormField<String>(
                                  value: selectedSemester,
                                  hint: const Text(
                                    "Select Sem",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  isExpanded: true,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.calendar_month_outlined,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                      horizontal: 10,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  items: semesters.map((String sem) {
                                    return DropdownMenuItem<String>(
                                      value: sem,
                                      child: Text(
                                        sem,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) =>
                                      setState(() => selectedSemester = value),
                                  validator: (value) => value == null
                                      ? "Please select sem"
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: themeColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: completeRegistration,
                          child: const Text(
                            "Complete Setup",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
