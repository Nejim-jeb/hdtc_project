import 'package:flutter/material.dart';

class MyConstants {
  static String testPhoto =
      'https://images.unsplash.com/photo-1650357519740-c888919621f8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80';
  static String firestoreMasterCollectionPath = 'master';
  static String firestoreBachelorCollectionPath = 'bachelor';
  static String firestoredoctorateCollectionPath = 'doctorate';
  static String firestoreUniCollectionPath = 'universities';

  static List<String> universities = [
    'Altınbaş University',
    'Antalya Bilim University',
    'Atılım University',
    'Bahçeşehir University',
    'Işik University',
    'Istanbul Arel University',
    'Istanbul Aydin University',
    'Istanbul Bilgi University',
    'Istanbul Esenyurt University',
    'Istanbul Gelisim University',
    'Istanbul Kültür University',
    'Istanbul Okan University',
    'Istinye University',
    'Kadırhas University',
    'Medipol University',
    'Nişantaşı University',
    'Özyeğin University',
    'Biruni University',
    'Haliç University',
    'Ibn Haldun University',
    'Istanbul Atlas University',
    'Istanbul Kent University',
    'Istanbul Sabahattin ZAIM University',
    'Istanbul Yeni Yüzyıl University',
    'Maltepe University',
    'Medipol Ankara University',
    'Sabacı University',
    'Üsküdar University',
  ];

  static List<String> specs = [
    'SPECIALIZATION',
    'Civil Engineering',
    'Information Technologies',
    'Industrial Products Design',
    'Architecture',
    'New Media',
    'Advertising',
    'Public Relations',
    'Communication Design',
    'Psychology',
    'Logistic Management',
    'Economics and Finance',
    'International Finance',
    'Political Science & International Relations',
    'International Trade and Business',
    'Business Administration',
    'Economics',
    'Psychological Counseling and Guidance',
    'Preschool Education',
    'English Language Teaching',
    'Educational Sciences',
    'Computer Education and Instructional Technologies',
    'Molecular Biology and Genetics',
    'Management Engineering',
    'Energy Systems Engineering',
    'Software Engineering',
    'Mechatronics Engineering',
    'Industrial Engineering',
    'Electrical and Electronics Engineering',
    'Biomedical Engineering',
    'Physiotherapy and Rehabilitation',
    'Social Work',
    'Child Development',
    'Nutrition and Dietetics',
    'Nursing',
    'Law',
    'Medicine',
    'Gastronomy and culinary arts',
    'Graphic Design',
    'Acting',
    'Cinema and Television',
    'Textile and Fashion Design',
    'English Language and Literature',
    'Mathematics',
    'Translation and Interpretation',
    'Translation and Interpretation (Russian)',
    'Sociology',
    'History',
    'Turkish language and literature',
    'Banking and Finance',
    'Tourism management',
    'nternational Relations',
    'International Trade',
    'Management Information Systems',
    'Industrial Design',
    'Chemical Engineering',
    'Mechanical Engineering',
    'Public Relations and Advertising',
    'Design of jewelry',
    'Social Services',
    'PHARMACY',
    'Health Management',
    'International Logistics Management',
    'Philosophy',
    'slamic sciences',
    'Entrepreneurship',
    'Business Informatics',
    'Translation and Interpreting',
    'Language and Speech Therapy',
    'Midwifery',
    'Occupational Therapy',
    'Mathematics Computer Science',
    'Art Management',
    'Interior Design',
    'Radio, Television and Cinema',
    'Journalism',
    'Accounting and Finance Management',
    'International Trade and Logistics',
    'Aviation Management',
    'Visual communication design',
    'Public Administration',
    'Advertising and Communication Design',
    'Tourism and Hotel Management',
    'Urban Design and Landscape Architecture',
    'International Logistics and Transportation',
    'Turkish Language and Literature Teaching',
    'Genetics and Bioengineering',
    'Food Engineering',
    'Material Science and Nanotechnology Engineering',
    'Theater',
    'Islamic Economics and Finance',
    'Management of Performing Arts',
    'Media and Communication Systems',
    'Television Reporting and Programming',
    'Communication Design and Management',
    'Digital Game Design',
    'Marketing',
    'Comparative Literature',
    'European Union Studies',
    'Music',
    'Political Science',
    'Perfusion',
    'Cartoon and animation',
    'New media and journalism',
    'Bioengineering',
    'Forensic science',
    'Occupational health and safety',
    'Prosthetics and Orthotics',
    'Management',
    'Drama and Acting',
    'Sports Management',
    'Arabic Language Teacher',
    'Primary Mathematics teacher',
    'Special Education Teacher',
    'Teacher Training Program for Gifted Students',
    'Turkish Language Teacher',
    'Physical Education and Sports Teaching',
    'Ergotherapy',
    'Media and Visible Arts',
    'nternational Trade and Finance',
    'Human Resources Management',
    'Banking and Insurance',
    'Humanities and Social Sciences',
    'Special Education Teaching',
    'Communication Arts',
    'Turkish-German Law',
    'Political Science and Public Administration',
    'Chemistry',
    'Opera and Concert Singing',
    'Turkish Music',
    'Public Relations and Publicity',
    'Coaching',
    'Recreation',
    'Bioinformatics and Genetics',
    'Interior Architecture',
    'ranslation and Interpreting (Arabic)',
    'Translation and Interpreting (Chinese)',
    'Tourism Guidance',
    'Automotive Engineering',
    'Logistics',
    'Pilotage',
    'Aircraft Body-Engine Maintenance',
    'Aircraft Engineering',
    'Exercise and Sport Sciences',
    'Electronics Engineering',
    'Molecular Biology, Genetics, and Bioengineering',
    'Cultural Studies',
    'Primary education',
    'Islamic Studies',
    'International Trade and Management',
    'Air Traffic Control',
    'Aircraft Electronics',
    'Real estate Management and Evaluation',
    'Computer Science',
    'Counseling Psychology',
    'ENGLISH PREPARATORY SCHOOL',
    'TURKISH PREPARATORY SCHOOL',
    'Cultural Affairs and Arts Management',
    'Finance',
    'Chemical Engineering and Applied Chemistry',
    'Information Systems Engineering',
    'Manufacturing Engineering',
    'Metallurgical and Materials Engineering',
    'Artificial Intelligence Engineering',
    'Sports Trainer Education',
    'Dentistry',
    'Software Development',
    'Interior Architecture and Environmental Design',
    'Music Teaching',
    'INTERIOR ARCHITECTURE AND ENVIRONMENT DESIGN',
    'PHYSICAL THERAPY AND REHABILITATION',
    'Computer Engineering',
    'english translation and interpreting',
    'GASTRONOMY AND CULINARY ARTS',
    'BANKING AND INSURANCE',
    'AVIATION MANAGEMENT',
    'AIRCRAFT MAINTAINANCE AND REPAIR',
    'NEW MEDIA AND COMMUNICATION',
    'logistics trade',
    'CIVIL AVIATION MANAGEMENT',
    'Musicology',
    'flight traninig',
    'Entertainment',
    'Audiology',
  ];

  static List<String> fields = [
    'Engineering and Natural Sciences',
    'Architecture and Design',
    'Communications and Arts',
    'Economics and Business',
    'Humanities and Social Sciences',
    'Education',
    'Literature and Languages',
    'Health Sciences',
    'Law',
    'Medical Sciences',
    'Tourism and Hospitality',
    'Aviation',
  ];

  static List<String> langs = ['English', 'Turkish', 'Arabic'];

  static List<DropdownMenuItem<String>> langList = langs
      .map((item) => DropdownMenuItem(value: item, child: (Text(item))))
      .toList();

  static List<DropdownMenuItem<String>> unisList = universities
      .map((item) => DropdownMenuItem(value: item, child: (Text(item))))
      .toList();

  static List<DropdownMenuItem<String>> fieldList = fields
      .map((item) => DropdownMenuItem(value: item, child: (Text(item))))
      .toList();

  static List<DropdownMenuItem<String>> specsList = specs
      .map((item) => DropdownMenuItem(value: item, child: (Text(item))))
      .toList();
}
