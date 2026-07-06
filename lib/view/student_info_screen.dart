import 'package:flutter/material.dart';

class StudentInfoScreen extends StatefulWidget {
  const StudentInfoScreen({super.key});

  @override
  State<StudentInfoScreen> createState() => _StudentInfoScreenState();
}

class _StudentInfoScreenState extends State<StudentInfoScreen> {
  String? selectedYearBatch = '22-23';
  String? selectedSemester;
  String? selectedYearLevel;

  final TextEditingController _rollNoController = TextEditingController();

  @override
  void dispose() {
    _rollNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    const primaryBlue = Color(0xff004197);
    const backgroundBlue = Color(0xfff0f4fd);
    const lightBlueInput = Color(0xffeaf4ff);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,

        appBar: AppBar(
          backgroundColor: const Color(0xfff8fafe),
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: primaryBlue,
              size: w * 0.06,
            ),
            onPressed: () {},
          ),
          title: Text(
            'Student Details',
            style: TextStyle(
              color: const Color(0xff0f2942),
              fontWeight: FontWeight.bold,
              fontSize: w * 0.05,
            ),
          ),
        ),

        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.06),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: h * 0.02),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Step 2 of 2",
                            style: TextStyle(
                              color: primaryBlue,
                              fontWeight: FontWeight.w600,
                              fontSize: w * 0.038,
                            ),
                          ),
                          Text(
                            "Personalization",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: w * 0.035,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: h * 0.015),

                      const LinearProgressIndicator(
                        value: 1,
                        minHeight: 6,
                        backgroundColor: backgroundBlue,
                        valueColor: AlwaysStoppedAnimation(primaryBlue),
                      ),

                      SizedBox(height: h * 0.03),

                      Text(
                        "Finalize Profile",
                        style: TextStyle(
                          fontSize: w * 0.065,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff0f2942),
                        ),
                      ),

                      SizedBox(height: h * 0.015),

                      Text(
                        "Please provide your academic credentials to finish your canteen registration.",
                        style: TextStyle(
                          fontSize: w * 0.038,
                          color: Colors.black54,
                          height: 1.4,
                        ),
                      ),

                      SizedBox(height: h * 0.03),

                      Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 500),

                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(w * 0.05),

                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(w * 0.06),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.08),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Roll Number",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blueAccent,
                                    fontSize: w * 0.04,
                                  ),
                                ),

                                SizedBox(height: h * 0.015),

                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: w * 0.04,
                                        vertical: h * 0.018,
                                      ),
                                      decoration: BoxDecoration(
                                        color: lightBlueInput,
                                        borderRadius:
                                            BorderRadius.circular(w * 0.03),
                                      ),
                                      child: Text(
                                        "UCSTT",
                                        style: TextStyle(
                                          fontSize: w * 0.037,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),

                                    SizedBox(width: w * 0.02),

                                    Expanded(
                                      child: DropdownButtonFormField<String>(
                                        value: selectedYearBatch,
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: lightBlueInput,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: w * 0.03,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(w * 0.03),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                        items: ["22-23", "23-24", "24-25"]
                                            .map((e) => DropdownMenuItem(
                                                  value: e,
                                                  child: Text(
                                                    e,
                                                    style: TextStyle(
                                                      fontSize: w * 0.037,
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedYearBatch = value;
                                          });
                                        },
                                      ),
                                    ),

                                    SizedBox(width: w * 0.02),

                                    Expanded(
                                      child: TextFormField(
                                        controller: _rollNoController,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: lightBlueInput,
                                          hintText: "Roll No",
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: w * 0.04,
                                            vertical: h * 0.018,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(w * 0.03),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: h * 0.025),

                                Text(
                                  "Semester",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: w * 0.04,
                                  ),
                                ),

                                SizedBox(height: h * 0.012),

                                DropdownButtonFormField<String>(
                                  value: selectedSemester,
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: lightBlueInput,
                                    prefixIcon: Icon(
                                      Icons.calendar_today_outlined,
                                      size: w * 0.05,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: w * 0.04,
                                      vertical: h * 0.018,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(w * 0.03),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  items: const [
                                    DropdownMenuItem(
                                      value: "First Semester",
                                      child: Text("First Semester"),
                                    ),
                                    DropdownMenuItem(
                                      value: "Second Semester",
                                      child: Text("Second Semester"),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      selectedSemester = value;
                                    });
                                  },
                                ),

                                SizedBox(height: h * 0.025),

                                Text(
                                  "Year Level",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: w * 0.04,
                                  ),
                                ),

                                SizedBox(height: h * 0.012),

                                DropdownButtonFormField<String>(
                                  value: selectedYearLevel,
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: lightBlueInput,
                                    prefixIcon: Icon(
                                      Icons.school_outlined,
                                      size: w * 0.05,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: w * 0.04,
                                      vertical: h * 0.018,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(w * 0.03),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  items: const [
                                    DropdownMenuItem(
                                      value: "First Year",
                                      child: Text("First Year"),
                                    ),
                                    DropdownMenuItem(
                                      value: "Second Year",
                                      child: Text("Second Year"),
                                    ),
                                    DropdownMenuItem(
                                      value: "Third Year",
                                      child: Text("Third Year"),
                                    ),
                                    DropdownMenuItem(
                                      value: "Fourth Year",
                                      child: Text("Fourth Year"),
                                    ),
                                    DropdownMenuItem(
                                      value: "Fifth Year",
                                      child: Text("Fifth Year"),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      selectedYearLevel = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: h * 0.03),
                    ],
                  ),
                ),
              ),

              SafeArea(
                top: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.06,
                    vertical: h * 0.02,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: h * 0.07,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(w * 0.08),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Complete Registration",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: w * 0.04,
                            ),
                          ),
                          SizedBox(width: w * 0.02),
                          Icon(
                            Icons.check_circle_outline,
                            color: Colors.white,
                            size: w * 0.05,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

