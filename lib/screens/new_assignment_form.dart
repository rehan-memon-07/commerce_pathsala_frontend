import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/theme_constants.dart';

class NewAssignmentForm extends StatefulWidget {
  const NewAssignmentForm({Key? key}) : super(key: key);

  @override
  State<NewAssignmentForm> createState() => _NewAssignmentFormState();
}

class _NewAssignmentFormState extends State<NewAssignmentForm> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  String _selectedClass = 'Class 10 - A';
  String _selectedSubject = 'Mathematics';
  String? _selectedFile;
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Assignment'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: ThemeConstants.primaryDark,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderIllustration(),
            Padding(
              padding: const EdgeInsets.all(ThemeConstants.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProgressIndicator(),
                  const SizedBox(height: ThemeConstants.xl),
                  _buildFormFields(),
                  const SizedBox(height: ThemeConstants.lg),
                  _buildSubmitButton(),
                  const SizedBox(height: ThemeConstants.lg),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderIllustration() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ThemeConstants.primaryBlue.withOpacity(0.1),
            Color(0xFF10B981).withOpacity(0.05),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: ThemeConstants.primaryBlue.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.assignment_rounded,
                  size: 50,
                  color: ThemeConstants.primaryBlue,
                ),
              ),
            )
                .animate()
                .fadeIn(duration: 600.ms)
                .scale(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Row(
      children: List.generate(
        3,
        (index) => Expanded(
          child: Container(
            height: 4,
            margin: EdgeInsets.symmetric(horizontal: index < 2 ? 4 : 0),
            decoration: BoxDecoration(
              color: index <= _currentStep ? ThemeConstants.primaryBlue : ThemeConstants.borderColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFormFieldLabel('Class', isRequired: true),
        const SizedBox(height: ThemeConstants.sm),
        _buildStyledDropdown(
          _selectedClass,
          ['Class 10 - A', 'Class 10 - B'],
          (value) => setState(() => _selectedClass = value),
        ),
        const SizedBox(height: ThemeConstants.lg),
        _buildFormFieldLabel('Subject', isRequired: true),
        const SizedBox(height: ThemeConstants.sm),
        _buildStyledDropdown(
          _selectedSubject,
          ['Mathematics', 'Science', 'English', 'History'],
          (value) => setState(() => _selectedSubject = value),
        ),
        const SizedBox(height: ThemeConstants.lg),
        _buildFormFieldLabel('Assignment Title', isRequired: true),
        const SizedBox(height: ThemeConstants.sm),
        _buildStyledTextField(
          _titleController,
          'Enter assignment title here',
          Icons.title_rounded,
        ),
        const SizedBox(height: ThemeConstants.lg),
        _buildFormFieldLabel('Description'),
        const SizedBox(height: ThemeConstants.sm),
        _buildStyledTextField(
          _descriptionController,
          'Provide detailed instructions for students...',
          Icons.description_rounded,
          maxLines: 5,
        ),
        const SizedBox(height: ThemeConstants.lg),
        _buildFormFieldLabel('Attachments'),
        const SizedBox(height: ThemeConstants.sm),
        _buildFileUploadArea(),
      ],
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.2);
  }

  Widget _buildFormFieldLabel(String label, {bool isRequired = false}) {
    return Row(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        if (isRequired)
          const Text(
            ' *',
            style: TextStyle(color: ThemeConstants.errorColor),
          ),
      ],
    );
  }

  Widget _buildStyledDropdown(
    String value,
    List<String> items,
    Function(String) onChanged,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ThemeConstants.borderColor),
        borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
      ),
      padding: const EdgeInsets.symmetric(horizontal: ThemeConstants.md),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) onChanged(newValue);
        },
      ),
    );
  }

  Widget _buildStyledTextField(
    TextEditingController controller,
    String hint,
    IconData icon, {
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ThemeConstants.borderColor),
        borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: ThemeConstants.md,
        vertical: ThemeConstants.sm,
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: ThemeConstants.textLight),
          border: InputBorder.none,
          icon: Icon(icon, color: ThemeConstants.primaryBlue, size: 20),
        ),
      ),
    );
  }

  Widget _buildFileUploadArea() {
    return GestureDetector(
      onTap: () {
        setState(() => _selectedFile = 'sample_file.pdf');
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: ThemeConstants.primaryBlue.withOpacity(0.3),
            style: BorderStyle.solid,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
          borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
          color: ThemeConstants.primaryBlue.withOpacity(0.02),
        ),
        padding: const EdgeInsets.all(ThemeConstants.lg),
        child: _selectedFile == null
            ? Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: ThemeConstants.primaryBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.attach_file_rounded,
                      color: ThemeConstants.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: ThemeConstants.md),
                  Text(
                    'Choose File',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Accepted file types: PDF, DOCX, JPG, PNG.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              )
            : Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: ThemeConstants.successColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.check_circle_rounded,
                      color: ThemeConstants.successColor,
                    ),
                  ),
                  const SizedBox(width: ThemeConstants.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _selectedFile!,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'File uploaded successfully',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: ThemeConstants.successColor,
                              ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _selectedFile = null),
                    child: const Icon(
                      Icons.close_rounded,
                      color: ThemeConstants.textLight,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Assignment created successfully!'),
            backgroundColor: ThemeConstants.successColor,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(ThemeConstants.lg),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
            ),
          ),
        );
        Navigator.of(context).pop();
      },
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: ThemeConstants.primaryBlue,
          borderRadius: BorderRadius.circular(ThemeConstants.radiusLg),
          boxShadow: [
            BoxShadow(
              color: ThemeConstants.primaryBlue.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Assignment created successfully!'),
                  backgroundColor: ThemeConstants.successColor,
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(ThemeConstants.lg),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
                  ),
                ),
              );
              Navigator.of(context).pop();
            },
            child: const Center(
              child: Text(
                'Submit Assignment',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.3);
  }
}
