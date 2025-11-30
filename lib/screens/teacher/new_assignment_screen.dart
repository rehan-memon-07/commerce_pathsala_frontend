// ============================================================================
// NEW ASSIGNMENT SCREEN
// ============================================================================
// Form for teachers to create and upload new assignments
// TODO: Implement file picker for attachments
// TODO: Add rich text editor for assignment description
// TODO: Add due date picker

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:commerce_paathshala_app/config/theme_config.dart';
import 'package:commerce_paathshala_app/models/assignment_model.dart';
import 'package:commerce_paathshala_app/providers/teacher_provider.dart';

class NewAssignmentScreen extends StatefulWidget {
  const NewAssignmentScreen({Key? key}) : super(key: key);

  @override
  State<NewAssignmentScreen> createState() => _NewAssignmentScreenState();
}

class _NewAssignmentScreenState extends State<NewAssignmentScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedClass;
  String? _selectedSubject;
  DateTime? _selectedDueDate;

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  double _formProgress = 0;

  @override
  void initState() {
    super.initState();
    _updateProgress();
  }

  /// Update form progress indicator
  void _updateProgress() {
    int filledFields = 0;
    const int totalFields = 5;

    if (_selectedClass != null) filledFields++;
    if (_selectedSubject != null) filledFields++;
    if (_titleController.text.isNotEmpty) filledFields++;
    if (_descriptionController.text.isNotEmpty) filledFields++;
    if (_selectedDueDate != null) filledFields++;

    setState(() {
      _formProgress = filledFields / totalFields;
    });
  }

  /// Handle assignment submission
  /// TODO: Validate all fields before submission
  /// TODO: Handle file upload to cloud storage
  /// TODO: Create assignment in backend
  Future<void> _submitAssignment() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedClass == null ||
        _selectedSubject == null ||
        _selectedDueDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields'),
        ),
      );
      return;
    }

    final teacherProvider = context.read<TeacherProvider>();

    // Create assignment object
    // NOTE: convert DateTime to a String since your model expects String dates
    final assignment = Assignment(
      id: 'assign_${DateTime.now().millisecondsSinceEpoch}',
      title: _titleController.text,
      description: _descriptionController.text,
      subject: _selectedSubject!,
      teacherName: 'Teacher', // TODO: Get from AuthProvider
      // convert to ISO string to match typical backend format
      dueDate: _selectedDueDate!,        // pass DateTime directly
      status: 'pending',
      createdAt: DateTime.now(),         // pass DateTime directly

    );

    final success = await teacherProvider.createAssignment(assignment);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Assignment created successfully')),
      );
      Navigator.of(context).pop();
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to create assignment')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Assignment'),
      ),
      body: Consumer<TeacherProvider>(
        builder: (context, teacherProvider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Illustration
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      color: ThemeConfig.lightBlueBackground,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text('✍️', style: TextStyle(fontSize: 100)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Form Progress
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Form Progress',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            '${(_formProgress * 100).toStringAsFixed(0)}%',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: _formProgress,
                          minHeight: 6,
                          backgroundColor: ThemeConfig.mediumGrey,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            ThemeConfig.primaryBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Class Selection
                  Text(
                    'Class *',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedClass,
                    hint: const Text('Select a class'),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: ['Class 10 - A', 'Class 10 - B', 'Class 11 - A']
                        .map((value) => DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() => _selectedClass = value);
                      _updateProgress();
                    },
                  ),
                  const SizedBox(height: 16),
                  // Subject Selection
                  Text(
                    'Subject *',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedSubject,
                    hint: const Text('Select a subject'),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: ['Mathematics', 'Science', 'English', 'History']
                        .map((value) => DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() => _selectedSubject = value);
                      _updateProgress();
                    },
                  ),
                  const SizedBox(height: 16),
                  // Title Field
                  Text(
                    'Assignment Title *',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: 'Enter assignment title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                    onChanged: (_) => _updateProgress(),
                  ),
                  const SizedBox(height: 16),
                  // Description Field
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Provide detailed instructions for students...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    maxLines: 5,
                    onChanged: (_) => _updateProgress(),
                  ),
                  const SizedBox(height: 16),
                  // Due Date Selection
                  Text(
                    'Due Date *',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate:
                        DateTime.now().add(const Duration(days: 365)),
                      );
                      if (pickedDate != null) {
                        setState(() => _selectedDueDate = pickedDate);
                        _updateProgress();
                      }
                    },
                    child: InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedDueDate?.toString().split(' ')[0] ??
                                'Select due date',
                          ),
                          const Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // File Upload (Placeholder)
                  Text(
                    'Attachments',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ThemeConfig.mediumGrey,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: ThemeConfig.lightGrey,
                    ),
                    child: InkWell(
                      onTap: () {
                        // TODO: Open file picker
                        // Use package: file_picker: ^5.5.0
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Text(
                              '📎',
                              style: TextStyle(fontSize: 40),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Choose File',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Accepted: PDF, DOCX, JPG, PNG',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Submit Button
                  ElevatedButton(
                    onPressed:
                    teacherProvider.isLoading ? null : _submitAssignment,
                    child: teacherProvider.isLoading
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        valueColor:
                        AlwaysStoppedAnimation<Color>(ThemeConfig.white),
                        strokeWidth: 2,
                      ),
                    )
                        : const Text('Submit Assignment'),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
