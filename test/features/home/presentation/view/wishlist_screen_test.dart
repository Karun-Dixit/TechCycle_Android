import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sprint1/features/home/data/model/product.dart';
import 'package:sprint1/features/home/presentation/bloc/home_bloc.dart';
import 'package:sprint1/features/home/presentation/bloc/home_event.dart';
import 'package:sprint1/features/home/presentation/bloc/home_state.dart';
import 'package:sprint1/features/home/presentation/view/wishlist_screen.dart';

// Mock class for HomeBloc
class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

void main() {
  late MockHomeBloc mockHomeBloc;

  setUp(() {
    mockHomeBloc = MockHomeBloc();
    // Set up an initial state with no wishlist items
    when(() => mockHomeBloc.state).thenReturn(HomeState.initial());
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<HomeBloc>.value(
          value: mockHomeBloc,
          child: const WishlistScreen(),
        ),
      ),
    );
  }

  group('WishlistScreen Widget Test', () {
    testWidgets('renders initial UI elements', (WidgetTester tester) async {
      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify initial UI elements
      expect(find.text('Wishlist'), findsOneWidget); // Header title
      expect(find.text('0 Items'), findsOneWidget); // Empty wishlist item count
      expect(find.byIcon(Icons.favorite_border), findsOneWidget); // Empty state icon
      expect(find.text('Your wishlist is empty'), findsOneWidget); // Empty state text
    });

    testWidgets('displays wishlist item when wishlist has items', (WidgetTester tester) async {
      // Update mock state to include wishlist items
      when(() => mockHomeBloc.state).thenReturn(
        HomeState.initial().copyWith(
          wishlistItems: [
            Product(
              name: 'Test Product',
              description: 'A test product description',
              price: 99.99,
              quantity: 5,
              status: 'Available',
            ),
          ],
        ),
      );

      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify wishlist item is displayed
      expect(find.text('Test Product'), findsOneWidget); // Product name
      expect(find.text('Rs. 99.99'), findsOneWidget); // Product price
      expect(find.text('In Stock'), findsOneWidget); // Stock status
      expect(find.byType(Card), findsOneWidget); // Card widget
      expect(find.byIcon(Icons.delete), findsOneWidget); // Delete button
    });

    testWidgets('renders "1 Items" text when wishlist has one item', (WidgetTester tester) async {
      // Update mock state to include one wishlist item
      when(() => mockHomeBloc.state).thenReturn(
        HomeState.initial().copyWith(
          wishlistItems: [
            Product(
              name: 'Test Product',
              description: 'A test product description',
              price: 99.99,
              quantity: 5,
              status: 'Available',
            ),
          ],
        ),
      );

      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify "1 Items" text is displayed
      expect(find.text('1 Items'), findsOneWidget);
    });

    testWidgets('renders "Out of Stock" text when quantity is zero', (WidgetTester tester) async {
      // Update mock state to include a product with zero quantity
      when(() => mockHomeBloc.state).thenReturn(
        HomeState.initial().copyWith(
          wishlistItems: [
            Product(
              name: 'Out of Stock Product',
              description: 'A test product description',
              price: 49.99,
              quantity: 0,
              status: 'Unavailable',
            ),
          ],
        ),
      );

      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify "Out of Stock" text is displayed
      expect(find.text('Out of Stock'), findsOneWidget);
    });

    testWidgets('renders loading indicator when isLoading is true', (WidgetTester tester) async {
      // Update mock state to set isLoading to true
      when(() => mockHomeBloc.state).thenReturn(
        HomeState.initial().copyWith(isLoading: true),
      );

      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify CircularProgressIndicator is not displayed (WishlistScreen doesn’t show it directly)
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('renders "No products found" message when wishlist is empty', (WidgetTester tester) async {
      // Update mock state to ensure wishlist is empty
      when(() => mockHomeBloc.state).thenReturn(
        HomeState.initial().copyWith(wishlistItems: [], isLoading: false),
      );

      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify "Your wishlist is empty" message is displayed
      expect(find.text('Your wishlist is empty'), findsOneWidget);
    });

    testWidgets('renders wishlist item image placeholder', (WidgetTester tester) async {
      // Update mock state to include a wishlist item with no image
      when(() => mockHomeBloc.state).thenReturn(
        HomeState.initial().copyWith(
          wishlistItems: [
            Product(
              name: 'Test Product',
              description: 'A test product description',
              price: 99.99,
              quantity: 5,
              status: 'Available',
            ),
          ],
        ),
      );

      // Pump the widget
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify the image placeholder (Icons.image_not_supported) is displayed
      expect(find.byIcon(Icons.image_not_supported), findsOneWidget);
    });
  });
}