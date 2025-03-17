import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/register.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

//-------------------- UI OF Home Page---------------------

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 33, 37, 243),
        centerTitle: true,
        title: const Text(
          "Lists Of Users",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            // 1) Handle Loading State
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // 2) Handle No Data
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No users found"));
            }

            // 3) Build DataTable
            final userDocs = snapshot.data!.docs;

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DataTable(
                  headingRowColor: WidgetStateProperty.resolveWith(
                    (states) => Colors.tealAccent.shade100,
                  ),
                  columnSpacing: 30,
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Username',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Email',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                  rows:
                      userDocs.asMap().entries.map((entry) {
                        final int index = entry.key;
                        final doc = entry.value;
                        final data = doc.data() as Map<String, dynamic>;

                        // Alternate row colors: one color for even, another for odd rows.
                        return DataRow(
                          color: WidgetStateProperty.resolveWith<Color>((
                            Set<WidgetState> states,
                          ) {
                            return index % 2 == 0
                                ? Colors.teal.shade50
                                : Colors.teal.shade100;
                          }),
                          cells: [
                            DataCell(
                              Text(
                                data['username'] ?? 'N/A',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                            DataCell(
                              Text(
                                data['email'] ?? 'N/A',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                            DataCell(
                              Text(
                                data['password'] ?? 'N/A',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          // Navigate to the RegisterPage
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => RegisterPage()));
        },
      ),
    );
  }
}
