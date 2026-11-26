// Temporary route argument contract. Nada supplies the actual screen in 04.
import '../../../models/listing.dart';
class ListingDetailsArgs {
  const ListingDetailsArgs(this.listing, {this.heroTag});
  final Object? heroTag;
  final Listing listing;
}
