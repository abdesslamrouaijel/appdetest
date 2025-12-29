import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewExpensePage extends StatefulWidget {
  final String userId;

  const NewExpensePage({super.key, required this.userId});

  @override
  State<NewExpensePage> createState() => _NewExpensePageState();
}

class _NewExpensePageState extends State<NewExpensePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  XFile? _receiptImage;

  // ================= PICK IMAGE =================
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    // ou ImageSource.camera

    if (pickedFile != null) {
      setState(() {
        _receiptImage = pickedFile;
      });
    }
  }

  // ================= SUBMIT EXPENSE =================
  void _submitExpense() {
    if (_formKey.currentState!.validate()) {
      final newExpense = {
        "id": DateTime.now().millisecondsSinceEpoch.toString(),
        "userId": widget.userId.trim().toLowerCase(),
        "category": _categoryController.text.trim(),
        "amount": double.parse(_amountController.text.trim()),
        "date": DateTime.now().toIso8601String().split('T')[0],
        "description": _descriptionController.text.trim(),
        "receiptPath": _receiptImage != null ? _receiptImage!.path : "",
        "status": "pending",
        "managerComment": null,
      };

      // Retourner la nouvelle dépense à la page précédente
      if (!mounted) return;
      Navigator.pop(context, newExpense);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nouvelle dépense"),
      backgroundColor: Colors.grey,),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg4.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Champ catégorie
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(
                  labelText: "Catégorie",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Veuillez entrer une catégorie" : null,
              ),
              const SizedBox(height: 16),

              // Champ montant
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: "Montant (MAD)",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? "Veuillez entrer un montant" : null,
              ),
              const SizedBox(height: 16),

              // Champ description
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // Aperçu simplifié de l'image
              _receiptImage != null
                  ? SizedBox(
                      height: 150,
                      child: Center(
                        child: Text(
                          "Image ajoutée : ${_receiptImage!.name}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : const SizedBox(
                      height: 150,
                      child: Center(
                        child: Text("Aucune image", style: TextStyle(color: Colors.white)),
                      ),
                    ),
              const SizedBox(height: 8),

              // Bouton pour ajouter un reçu
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image),
                label: const Text("Ajouter un reçu"),
              ),
              const SizedBox(height: 24),

              // Bouton pour enregistrer la dépense
              ElevatedButton(
                onPressed: _submitExpense,
                child: const Text("Enregistrer"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
