import 'package:contacts_service/contacts_service.dart';
import 'package:url_launcher/url_launcher.dart';
import './main.dart';
import 'package:flutter/material.dart';

TextEditingController searchController = new TextEditingController();

class ReadingContacts extends StatefulWidget {
  @override
  _ReadingContactsState createState() => _ReadingContactsState();
}

class _ReadingContactsState extends State<ReadingContacts> {
  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      filterContacts();
    });
  }

  filterContacts() {
    List<Contact> _contacts = [];
    _contacts.addAll(contactsList);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String contactName = contact.displayName.toLowerCase();
        return contactName.contains(searchTerm);
      });
      setState(() {
        contactsListFilter = _contacts;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    print(isSearching);
    return Container(
      padding: EdgeInsets.all(10),
      //margin: EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          Container(
            // padding: EdgeInsets.all(10),
            child: TextField(
              onTap: (){
                
              },
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                border: new OutlineInputBorder(
                  borderSide: new BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: (contactsList.length > 0)
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: isSearching == true
                        ? contactsListFilter.length
                        : contactsList.length,
                    itemBuilder: (context, index) {
                      Contact contact = isSearching == true
                          ? contactsListFilter[index]
                          : contactsList[index];
                      return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Center(
                              child: (contact.avatar != null)
                                  ? Image.memory(
                                      contact.avatar,
                                      fit: BoxFit.cover,
                                      height: 28,
                                      width: 28,
                                    )
                                  : CircleAvatar(
                                      child: Text('X'),
                                    ),
                            ),
                          ),
                          title: Text("${contact.displayName}"),
                          subtitle: Text((contact.phones.length > 0)
                              ? "${contact.phones.elementAt(0).value}"
                              : "No Contact Informations Found"),
                          trailing: InkWell(
                            child: Icon(
                              Icons.call,
                              color: Colors.blue,
                            ),
                            onTap: () {
                              _makePhoneCall(
                                  "tel:${contact.phones.elementAt(0).value}");
                            },
                          ));
                    })
                : Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          backgroundColor: Colors.red,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text('Fetching Contacts'),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

void _makePhoneCall(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
