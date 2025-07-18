import 'package:flutter/material.dart';

class AddNewContactScreen extends StatefulWidget {
  const AddNewContactScreen({super.key});

  @override
  State<AddNewContactScreen> createState() => _AddNewContactScreenState();
}

class _AddNewContactScreenState extends State<AddNewContactScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  int _selectedAvatar = 0;
  final List<String> _avatars = [
    'https://i.pravatar.cc/150?img=6',
    'https://i.pravatar.cc/150?img=7',
    'https://i.pravatar.cc/150?img=8',
  ];

  bool get isVerified => _usernameController.text.trim() == '@verified';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Add New Contact',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6D5BFF), Color(0xFF00C6FB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(_avatars[_selectedAvatar]),
                      radius: 40,
                    ),
                    if (isVerified)
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 14,
                        child: Icon(
                          Icons.verified,
                          color: Colors.blue,
                          size: 20,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _avatars.length,
                    (i) => GestureDetector(
                      onTap: () => setState(() => _selectedAvatar = i),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: EdgeInsets.all(_selectedAvatar == i ? 3 : 0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _selectedAvatar == i
                                ? Colors.deepPurple
                                : Colors.transparent,
                            width: 2,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(_avatars[i]),
                          radius: 22,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _buildTextField(_nameController, 'Name'),
                const SizedBox(height: 16),
                _buildTextField(
                  _usernameController,
                  '@username',
                  onChanged: (_) => setState(() {}),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      // For demo, just pop
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    ValueChanged<String>? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withAlpha((0.15 * 255).round()),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.08 * 255).round()),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white70),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
