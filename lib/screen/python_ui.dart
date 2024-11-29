// screens/python_code_executor_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class PythonCodeExecutorScreen extends StatefulWidget {
  @override
  _PythonCodeExecutorScreenState createState() => _PythonCodeExecutorScreenState();
}

class _PythonCodeExecutorScreenState extends State<PythonCodeExecutorScreen> {
  final TextEditingController _codeController = TextEditingController();
  String _outputText = '';
  bool _isLoading = false;
  final FocusNode _codeFocusNode = FocusNode();

  Future<void> _executePythonCode() async {
    if (_codeController.text.trim().isEmpty) {
      _showSnackBar('Please enter Python code to execute.');
      return;
    }

    setState(() {
      _isLoading = true;
      _outputText = '';
    });

    try {
      final response = await http.post(
        Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=YOUR_API_KEY',
        ),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {
                  'text':
                      'Execute the following Python code and return only its output. Do not include any additional explanation or code. If there are any errors, return the error message, Check also for the python identation and syntax error if any dont give ouput just specify error:\n\n${_codeController.text}'
                }
              ]
            }
          ],
          'generationConfig': {
            'temperature': 0.2,
            'maxOutputTokens': 2048,
          }
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final output = jsonResponse['candidates'][0]['content']['parts'][0]['text'];

        setState(() {
          _outputText = output.trim();
          _isLoading = false;
        });
      } else {
        setState(() {
          _outputText = 'Error executing code: ${response.body}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _outputText = 'An error occurred: $e';
        _isLoading = false;
      });
    }
  }

  void _clearAll() {
    setState(() {
      _codeController.clear();
      _outputText = '';
    });
    FocusScope.of(context).requestFocus(_codeFocusNode);
    _showSnackBar('Code and output cleared');
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    _showSnackBar('Copied to clipboard');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.robotoMono(),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF3C3C3C),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E), // Dark background
      appBar: AppBar(
        backgroundColor: Color(0xFF252526),
        title: Text(
          'Python Code Executor',
          style: GoogleFonts.robotoMono(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Code Input Area
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF252526), // Slightly lighter than background
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFF3C3C3C)),
                ),
                child: Scrollbar(
                  child: TextField(
                    focusNode: _codeFocusNode,
                    controller: _codeController,
                    maxLines: null,
                    expands: true,
                    cursorColor: Colors.greenAccent,
                    style: GoogleFonts.robotoMono(
                      color: Colors.greenAccent,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter your Python code here...',
                      hintStyle: GoogleFonts.robotoMono(
                        color: Colors.grey.shade600,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(12),
                    ),
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _actionButton(
                  text: 'Clear All',
                  icon: Icons.clear_all,
                  color: Colors.redAccent,
                  onPressed: _clearAll,
                ),
                SizedBox(width: 16),
                _actionButton(
                  text: 'Run',
                  icon: Icons.play_arrow,
                  color: Colors.greenAccent,
                  onPressed: _executePythonCode,
                ),
              ],
            ),
            SizedBox(height: 16),

            // Output Area
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF252526),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFF3C3C3C)),
                ),
                child: Stack(
                  children: [
                    _isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.greenAccent,
                            ),
                          )
                        : SingleChildScrollView(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              _outputText.isEmpty 
                                ? 'Output will appear here...' 
                                : _outputText,
                              style: GoogleFonts.robotoMono(
                                color: _outputText.contains('Error') 
                                  ? Colors.redAccent 
                                  : Colors.greenAccent,
                                fontSize: 14,
                              ),
                            ),
                          ),
                    
                    // Copy Button
                    if (_outputText.isNotEmpty)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          icon: Icon(
                            Icons.copy,
                            color: Colors.grey.shade600,
                          ),
                          onPressed: () => _copyToClipboard(_outputText),
                          tooltip: 'Copy Output',
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

  Widget _actionButton({
    required String text,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      icon: Icon(icon, color: Colors.white),
      label: Text(
        text,
        style: GoogleFonts.robotoMono(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 3,
      ),
      onPressed: onPressed,
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    _codeFocusNode.dispose();
    super.dispose();
  }
}