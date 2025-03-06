import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sprint1/features/home/data/model/product.dart';
import 'package:sprint1/features/home/presentation/bloc/home_bloc.dart';
import 'package:sprint1/features/home/presentation/bloc/home_event.dart';
import 'package:sprint1/features/home/presentation/bloc/home_state.dart';
import 'package:sprint1/features/home/presentation/view/home_view.dart';

// Mock class for HomeBloc
class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

void main() {
  late MockHomeBloc mockHomeBloc;

  setUp(() {
    mockHomeBloc = MockHomeBloc();
    // Set up an initial state with no cart items
    when(() => mockHomeBloc.state).thenReturn(HomeState.initial());
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<HomeBloc>.value(
          value: mockHomeBloc,
          child: const DashboardScreen(),
        ),
      ),
    );
  }

  group('DashboardScreen Widget Test', () {
    testWidgets('renders initial UI elements', (WidgetTester tester) async {
      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify initial UI elements
      expect(find.text('TechCycle'), findsOneWidget); // App bar title
      expect(find.byType(TextField), findsOneWidget); // Search bar
      expect(find.text('Categories'), findsOneWidget); // Categories section
      expect(find.byIcon(Icons.phone_android),
          findsOneWidget); // First category icon
      expect(find.text('Phones'), findsOneWidget); // First category label
    });

    testWidgets('displays cart badge when cart has items',
        (WidgetTester tester) async {
      // Update mock state to include cart items
      when(() => mockHomeBloc.state).thenReturn(
        HomeState.initial().copyWith(
          cartItems: [
            Product(
              name: 'Test Product',
              description: 'A test product description',
              price: 99.99,
              quantity: 10,
              status: 'Available',
            ),
          ],
        ),
      );

      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify cart icon and badge
      expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
      expect(find.text('1'), findsOneWidget); // Badge with cart item count
    });

    testWidgets('renders "Recent Products" text', (WidgetTester tester) async {
      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify "Recent Products" text is displayed
      expect(find.text('Recent Products'), findsOneWidget);
    });

    testWidgets('renders "Shop Now" button', (WidgetTester tester) async {
      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify "Shop Now" button is present
      expect(find.widgetWithText(ElevatedButton, 'Shop Now'), findsOneWidget);
    });

    testWidgets('renders "All" category', (WidgetTester tester) async {
      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify "All" category is displayed
      expect(find.text('All'), findsOneWidget);
    });

    testWidgets('renders "Monitors" category', (WidgetTester tester) async {
      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify "Monitors" category is displayed
      expect(find.text('Monitors'), findsOneWidget);
    });

    testWidgets('renders banner image asset', (WidgetTester tester) async {
      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify the Image.asset widget is present (laptop.png)
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('renders "Sort/Filter" text button',
        (WidgetTester tester) async {
      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify "Sort/Filter" TextButton is present
      expect(find.widgetWithText(TextButton, 'Sort/Filter'), findsOneWidget);
    });

    testWidgets('renders loading indicator when isLoading is true',
        (WidgetTester tester) async {
      // Update mock state to set isLoading to true
      when(() => mockHomeBloc.state).thenReturn(
        HomeState.initial().copyWith(isLoading: true),
      );

      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify CircularProgressIndicator is displayed
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders "No products found" message when products are empty',
        (WidgetTester tester) async {
      // Update mock state to ensure filteredProducts is empty
      when(() => mockHomeBloc.state).thenReturn(
        HomeState.initial().copyWith(products: [], isLoading: false),
      );

      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify "No products found" message is displayed
      expect(find.text('No products found'), findsOneWidget);
    });

    testWidgets('renders "Best Deals on Laptops" text in banner',
        (WidgetTester tester) async {
      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify "Best Deals on Laptops" text is displayed
      expect(find.text("Best Deals\non Laptops"), findsOneWidget);
    });

    testWidgets('renders "Consoles" category', (WidgetTester tester) async {
      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify "Consoles" category is displayed
      expect(find.text('Consoles'), findsOneWidget);
    });

    testWidgets('renders search bar hint text', (WidgetTester tester) async {
      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify the hint text in the search bar
      expect(find.text('Search products...'), findsOneWidget);
    });

    testWidgets('renders error message when errorMessage is set',
        (WidgetTester tester) async {
      // Update mock state to set an error message
      when(() => mockHomeBloc.state).thenReturn(
        HomeState.initial().copyWith(
            errorMessage: 'Failed to load products', isLoading: false),
      );

      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify error message is displayed
      expect(find.text('Failed to load products'), findsOneWidget);
    });

    testWidgets('renders "Headphones" category text',
        (WidgetTester tester) async {
      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify "Headphones" category text is displayed
      expect(find.text('Headphones'), findsOneWidget);
    });

    testWidgets('renders "Phones" category text', (WidgetTester tester) async {
      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify "Phones" category text is displayed
      expect(find.text('Phones'), findsOneWidget);
    });

    testWidgets('renders "Consoles" category text',
        (WidgetTester tester) async {
      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify "Consoles" category text is displayed
      expect(find.text('Consoles'), findsOneWidget);
    });

    testWidgets('renders "Monitors" category text',
        (WidgetTester tester) async {
      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify "Monitors" category text is displayed
      expect(find.text('Monitors'), findsOneWidget);
    });

    testWidgets('renders "All" category text', (WidgetTester tester) async {
      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify "All" category text is displayed
      expect(find.text('All'), findsOneWidget);
    });

    // New Test 1: Verifies the "Consoles" category icon
    testWidgets('renders "Consoles" category icon',
        (WidgetTester tester) async {
      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify the Consoles category icon is displayed
      expect(find.byIcon(Icons.videogame_asset), findsOneWidget);
    });

    // New Test 2: Verifies the "Monitors" category icon
    testWidgets('renders "Monitors" category icon',
        (WidgetTester tester) async {
      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify the Monitors category icon is displayed
      expect(find.byIcon(Icons.tv), findsOneWidget);
    });

    // New Test 3: Verifies the "All" category icon
    testWidgets('renders "All" category icon', (WidgetTester tester) async {
      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify the All category icon is displayed
      expect(find.byIcon(Icons.apps), findsOneWidget);
    });

    // New Test 4: Verifies the "Headphones" category icon
    testWidgets('renders "Headphones" category icon',
        (WidgetTester tester) async {
      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify the Headphones category icon is displayed
      expect(find.byIcon(Icons.headphones), findsOneWidget);
    });
  });
}
