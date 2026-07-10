
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smartcanteen/model/student_model.dart';
import 'package:smartcanteen/model/user_model.dart';

class StudentInfoScreen extends StatefulWidget {
   final UserModel user;
  const StudentInfoScreen({super.key, required this.user});

  @override

  State<StudentInfoScreen> createState() => _StudentInfoScreenState();
}

class _StudentInfoScreenState extends State<StudentInfoScreen> {
  
  String? selectedYearBatch = "22-23";
  String? selectedSemester;
  String? selectedYearLevel;

  final TextEditingController _rollNoController =
      TextEditingController();

  @override
  void dispose() {
    _rollNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     print(widget.user.userName);
  print(widget.user.userEmail);
  print(widget.user.userPhone);
    final size = MediaQuery.of(context).size;

    final w = size.width;
    final h = size.height;

    const primaryBlue = Color(0xff004197);
    const backgroundBlue = Color(0xfff0f4fd);
    const lightBlueInput = Color(0xffEAF4FF);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
  backgroundColor: Colors.white,
  surfaceTintColor: Colors.transparent,
  elevation: 0,
  scrolledUnderElevation: 0,
  leading: IconButton(
    icon: const Icon(
      Icons.arrow_back,
      color: Colors.black,
    ),
    onPressed: () {
      context.go("/register");
    },
  ),
),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color(0xFFEDF4FA),
              Color(0xFFDBE9F6),
            ],
            stops: [0.0, 0.6, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //SizedBox(height: h * 0.02),

                // Row(
                //   mainAxisAlignment:
                //       MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       "Step 2 of 2",
                //       style: TextStyle(
                //         color: primaryBlue,
                //         fontWeight: FontWeight.w600,
                //         fontSize: w * 0.038,
                //       ),
                //     ),
                //     Text(
                //       "Personalization",
                //       style: TextStyle(
                //         color: Colors.grey,
                //         fontSize: w * 0.035,
                //       ),
                //     ),
                //   ],
                // ),

                // SizedBox(height: h * 0.015),

                // const LinearProgressIndicator(
                //   value: 1,
                //   minHeight: 6,
                //   backgroundColor: backgroundBlue,
                //   valueColor: AlwaysStoppedAnimation(
                //     primaryBlue,
                //   ),
                // ),

                // SizedBox(height: h * 0.03),

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

               Container(
  width: double.infinity,
  padding: EdgeInsets.all(w * 0.05),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(w * 0.06),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 15,
        offset: const Offset(0, 8),
      ),
    ],
  ),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Roll Number",
        style: TextStyle(
          fontWeight: FontWeight.w600,
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
              borderRadius: BorderRadius.circular(w * 0.03),
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
              decoration: InputDecoration(
                filled: true,
                fillColor: lightBlueInput,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(w * 0.03),
                  borderSide: BorderSide.none,
                ),
              ),
              items: ["22-23", "23-24", "24-25"]
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(w * 0.03),
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
          hintText: "Select Semester",
          prefixIcon: Icon(
            Icons.calendar_today_outlined,
            size: w * 0.05,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(w * 0.03),
            borderSide: BorderSide.none,
          ),
        ),
        items: const [
          DropdownMenuItem(
            value: "1",
            child: Text("First Semester"),
          ),
          DropdownMenuItem(
            value: "2",
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
          hintText: "Select Year Level",
          prefixIcon: Icon(
            Icons.school_outlined,
            size: w * 0.05,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(w * 0.03),
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

      SizedBox(height: h * 0.04),

      SizedBox(
        width: double.infinity,
        height: h * 0.07,
        child: ElevatedButton(
          onPressed: () {

  final studentInfo = StudentModel(
    studentId: "UCSTT(${selectedYearBatch})-${_rollNoController.text}",
    semester: selectedSemester!,
    yearLevel: selectedYearLevel!, 
    userId:0, 
    academicYear: '${selectedYearBatch}', 
    createdAt: DateTime.now().toString(), 
    updatedAt: DateTime.now().toString(),
  );


  final updatedUser = UserModel(
    userId: widget.user.userId,
    userName: widget.user.userName,
    userPhone: widget.user.userPhone,
    userEmail: widget.user.userEmail,
    roleName: widget.user.roleName,
    fcmToken: widget.user.fcmToken,
    updatedAt: widget.user.updatedAt,
    createdAt: widget.user.createdAt,
    student: studentInfo, 
    userPassword: widget.user.userPassword,
  );


  context.go(
    "/wallet_info",
    extra: updatedUser,
  );

},
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBlue,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(w * 0.08),
            ),
          ),
          child: Text(
            "Complete Registration",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: w * 0.042,
            ),
          ),
        ),
      ),
    ],
  ),
),
                //SizedBox(height: h * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


