import 'package:cab_economics/models/ride_supplier.dart';
import 'package:cab_economics/providers/ride_supplier_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditRemoveButtonListTile extends StatefulWidget {
  final void Function(bool?, RideSupplier?) onAddNewOrEditTap;
  final void Function(String, int) onDeleteTap;

  const EditRemoveButtonListTile({
    super.key,
    required this.onAddNewOrEditTap,
    required this.onDeleteTap,
  });

  @override
  State<EditRemoveButtonListTile> createState() =>
      _EditRemoveButtonListTileState();
}

class _EditRemoveButtonListTileState extends State<EditRemoveButtonListTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RideSupplierProvider>(
      builder: (context, data, child) {
        if (data.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
                itemCount: data.rideSuppliers.length,
                itemBuilder: (ctx, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                              title: Text(
                                data.rideSuppliers[index].name!,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      color: Colors.blueAccent,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                    ),
                                    child: IconButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        // resetCallback;
                                        //
                                        widget.onAddNewOrEditTap(
                                            true, data.rideSuppliers[index]);
                                      },
                                      icon: const Icon(Icons.edit),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                    ),
                                    child: IconButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        widget.onDeleteTap(
                                          data.rideSuppliers[index].name!,
                                          index,
                                        );
                                      },
                                      icon: Icon(Icons.delete),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                )),
          );
        }
      },
    );

    ;
  }
}
