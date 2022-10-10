import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pc1/pages/Daily%20Progress/Today%20All/todayallpc.dart';
import 'package:pc1/services/writedata.dart';

class NewCustFormPage extends StatefulWidget {
  final String mobileno;
  final String name;
  final String pcno;
  NewCustFormPage(
      {Key? key,
      required this.mobileno,
      required this.pcno,
      required this.name})
      : super(key: key);

  @override
  State<NewCustFormPage> createState() => _NewCustFormPageState();
}

class _NewCustFormPageState extends State<NewCustFormPage> {
  late String _pcNumber = widget.pcno;
  late String _item;
  late String _bringWithItem = "";
  late String _problem;
  late String _cost;
  late String _remarks;
  final _formKey = GlobalKey<FormState>();
  String? item;
  bool laptop = false;
  bool printer = false;
  bool computer = false;
  bool other = false;
  bool is_checked1 = false;
  bool is_checked2 = false;
  bool is_checked3 = false;
  late String Bitem = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 246, 255),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(255, 16, 121, 174),
        title: Text('New Customers',
            style:
                GoogleFonts.ubuntu(fontSize: 25, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: const Border(
                      top: BorderSide(width: 1.5, color: Colors.black),
                      left: BorderSide(width: 1.5, color: Colors.black),
                      right: BorderSide(width: 1.5, color: Colors.black),
                      bottom: BorderSide(width: 1.5, color: Colors.black),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Text(
                            "Name: ",
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          SizedBox(width: 15),
                          Text(
                            widget.name,
                            style: GoogleFonts.poppins(
                                fontSize: 17, color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Text(
                            "Mobile No: ",
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          SizedBox(width: 15),
                          Text(
                            widget.mobileno,
                            style: GoogleFonts.poppins(
                                fontSize: 17, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: widget.pcno,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.design_services),
                            labelText: 'Enter Pc Number',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _pcNumber = value;
                            });
                          },
                        ),
                      ),
                      //box styling
                      const SizedBox(height: 10),
                      //text input
                      Row(
                        children: [
                          Row(
                            children: <Widget>[
                              Radio<String>(
                                  value: "Laptop",
                                  groupValue: item,
                                  onChanged: (value) {
                                    item = value.toString();
                                    _item = item!;
                                    setState(() {
                                      laptop = true;
                                      printer = false;
                                      computer = false;
                                      other = false;
                                    });
                                  }),
                              const Text('Laptop',
                                  style: TextStyle(fontSize: 20))
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Radio<String>(
                                  value: "Printer",
                                  groupValue: item,
                                  onChanged: (value) {
                                    item = value.toString();
                                    _item = item!;
                                    setState(() {
                                      laptop = false;
                                      printer = true;
                                      computer = false;
                                      other = false;
                                    });
                                  }),
                              const Text('Printer',
                                  style: TextStyle(fontSize: 20))
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Row(
                            children: <Widget>[
                              Radio<String>(
                                  value: "Computer",
                                  groupValue: item,
                                  onChanged: (value) {
                                    item = value.toString();
                                    _item = item!;
                                    setState(() {
                                      laptop = false;
                                      printer = false;
                                      computer = true;
                                      other = false;
                                    });
                                  }),
                              const Text('Computer',
                                  style: TextStyle(fontSize: 20))
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Radio<String>(
                                  value: "Other",
                                  groupValue: item,
                                  onChanged: (value) {
                                    item = value.toString();
                                    _item = item!;
                                    setState(() {
                                      laptop = false;
                                      printer = false;
                                      computer = false;
                                      other = true;
                                    });
                                  }),
                              const Text('Other',
                                  style: TextStyle(fontSize: 20))
                            ],
                          ),
                        ],
                      ),
                      laptop
                          ? Column(
                              children: [
                                CheckboxListTile(
                                    title: Text("Charger"),
                                    value: is_checked1,
                                    onChanged: (value) {
                                      setState(() {
                                        is_checked1 = value!;
                                        if (is_checked1 == true) {
                                          _bringWithItem =
                                              _bringWithItem + " Charger,";
                                        } else {
                                          _bringWithItem = "";
                                        }
                                      });
                                    }),
                                CheckboxListTile(
                                    title: Text("Bag"),
                                    value: is_checked2,
                                    onChanged: (value) {
                                      setState(() {
                                        is_checked2 = value!;
                                        if (is_checked2 == true) {
                                          _bringWithItem =
                                              _bringWithItem + " Bag,";
                                        } else {
                                          _bringWithItem = "";
                                        }
                                      });
                                    }),
                                CheckboxListTile(
                                    title: Text("Power Cable"),
                                    value: is_checked3,
                                    onChanged: (value) {
                                      setState(() {
                                        is_checked3 = value!;
                                        if (is_checked3 == true) {
                                          _bringWithItem =
                                              _bringWithItem + " Power Cable,";
                                        } else {
                                          _bringWithItem = "";
                                        }
                                      });
                                    }),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    initialValue: _bringWithItem,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.list),
                                      labelText: 'bring item',
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        Bitem = value;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(_bringWithItem + Bitem),
                                  ),
                                ),
                              ],
                            )
                          : SizedBox(
                              height: 0,
                              width: 0,
                            ),
                      printer
                          ? Column(
                              children: [
                                CheckboxListTile(
                                    title: Text("Printer Cable"),
                                    value: is_checked1,
                                    onChanged: (value) {
                                      setState(() {
                                        is_checked1 = value!;
                                        if (is_checked1 == true) {
                                          _bringWithItem = _bringWithItem +
                                              " Printer Cable,";
                                        } else {
                                          _bringWithItem = "";
                                        }
                                      });
                                    }),
                                CheckboxListTile(
                                    title: Text("Cartridz"),
                                    value: is_checked2,
                                    onChanged: (value) {
                                      setState(() {
                                        is_checked2 = value!;
                                        if (is_checked2 == true) {
                                          _bringWithItem =
                                              _bringWithItem + " Cartridz,";
                                        } else {
                                          _bringWithItem = "";
                                        }
                                      });
                                    }),
                                CheckboxListTile(
                                    title: Text("Power Cable"),
                                    value: is_checked3,
                                    onChanged: (value) {
                                      setState(() {
                                        is_checked3 = value!;
                                        if (is_checked3 == true) {
                                          _bringWithItem =
                                              _bringWithItem + " Power Cable,";
                                        } else {
                                          _bringWithItem = "";
                                        }
                                      });
                                    }),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    initialValue: _bringWithItem,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.list),
                                      labelText: 'bring item',
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        Bitem = value;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(_bringWithItem + Bitem),
                                  ),
                                ),
                              ],
                            )
                          : SizedBox(
                              height: 0,
                              width: 0,
                            ),
                      computer
                          ? Column(
                              children: [
                                CheckboxListTile(
                                    title: Text("Charger"),
                                    value: is_checked1,
                                    onChanged: (value) {
                                      setState(() {
                                        is_checked1 = value!;
                                        if (is_checked1 == true) {
                                          _bringWithItem =
                                              _bringWithItem + " Charger,";
                                        } else {
                                          _bringWithItem = "";
                                        }
                                      });
                                    }),
                                CheckboxListTile(
                                    title: Text("Power Cable"),
                                    value: is_checked2,
                                    onChanged: (value) {
                                      setState(() {
                                        is_checked2 = value!;
                                        if (is_checked2 == true) {
                                          _bringWithItem =
                                              _bringWithItem + " Power Cable,";
                                        } else {
                                          _bringWithItem = "";
                                        }
                                      });
                                    }),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    initialValue: _bringWithItem,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.list),
                                      labelText: 'bring item',
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        Bitem = value;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(_bringWithItem + Bitem),
                                  ),
                                ),
                              ],
                            )
                          : SizedBox(
                              height: 0,
                              width: 0,
                            ),
                      other
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.devices),
                                      labelText: 'Enter item',
                                      hintText: 'laptop/pc',
                                      border: OutlineInputBorder(),
                                    ),
                                    onFieldSubmitted: (value) {},
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter a Item Name';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        _item = value;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.list),
                                      labelText:
                                          'bring item',
                                      hintText:
                                          'Charger, Bag ',
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _bringWithItem = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(height: 0, width: 0),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.report),
                            labelText: 'Write problem of item',
                            hintText: 'problem:',
                            border: OutlineInputBorder(),
                          ),
                          onFieldSubmitted: (value) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter a Problem';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              _problem = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: const Icon(Icons.attach_money),
                            labelText: 'Enter Estimate cost',
                            hintText: '2000',
                            border: const OutlineInputBorder(),
                          ),
                          onFieldSubmitted: (value) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter a Cost';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              _cost = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            hintText: "Enter Remarks",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _remarks = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            final isValid = _formKey.currentState!.validate();
                            if (!isValid) {
                              return;
                            }
                            _formKey.currentState!.save();
                            _bringWithItem = _bringWithItem + Bitem;
                            Map<String, dynamic> ItemData = {
                              'Pc No': _pcNumber,
                              'Mobile No': widget.mobileno,
                              'Name': widget.name,
                              'Item': _item,
                              'Bring Item': _bringWithItem,
                              'Problem': _problem,
                              'Cost': _cost,
                              'Remarks': _remarks,
                              'Progress': "Pending",
                              'Date': DateTime.now(),
                            };
                            WriteData().addPcData(ItemData, context).then(
                              (result) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Item added"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              },
                            );
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TodayAllPcPage()),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 16, 121, 174),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
