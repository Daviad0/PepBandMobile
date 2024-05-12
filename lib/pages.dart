import 'package:flutter/material.dart';
import 'package:pep/page_events.dart';

// data for a specific page
class PageData {
  String pageTitle;
  Widget mainContent;
  dynamic pageData;


  PageData({required this.pageTitle, required this.pageData, required this.mainContent});
}

// the general storage for pages (and the current page)
// notifies on data change
class PageStorage{
  static Map<String, PageData> pages = {};
  static PageData? currentPage = null;
}

// stores all of the available pages, pulling in from other dart files
void initializePageStorage(){
  PageStorage.pages = PageStorage.pages = {
    "Home" : new PageData(
        mainContent: Container(
            height: 50,
            width: 50,
            color: Colors.red
        ),
        pageTitle: "Landing Page",
        pageData: {}
    ),
    "Page2" : new PageData(
        mainContent: Container(
            height: 50,
            width: 50,
            color: Colors.blue
        ),
        pageTitle: "Test Page",
        pageData: {}
    ),
    "Events": new PageData(
      mainContent: new AllEvents(handleInvisible: false),
      pageData: {},
      pageTitle: "Events"
    )
  };
}

// returns list of all of the pages
Map<String, PageData> pages(){
  return PageStorage.pages;
}

PageData? getCurrentPage(){
  return PageStorage.currentPage;
}

void setPage(PageData page){
  PageStorage.currentPage = page;
}

