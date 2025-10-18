import 'package:flowery_tracking/features/pickupLocation/domain/entities/delivery_location.dart';
import 'package:flowery_tracking/features/pickupLocation/presentation/widgets/delivery_card.dart';
import 'package:flutter/material.dart';

class DeliveryBottomSheet extends StatelessWidget {

  const DeliveryBottomSheet({
    super.key,
    required this.deliveryLocations,
    required this.selectedCardIndex,
    required this.onCardTap,
  });
  final List<DeliveryLocation> deliveryLocations;
  final int? selectedCardIndex;
  final Function(int) onCardTap;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.35,
      minChildSize: 0.2,
      maxChildSize: 0.7,
      builder: (context, scrollController) {
        // Reorder items to show selected first
        final List<int> orderedIndices = List.generate(deliveryLocations.length, (i) => i);
        if (selectedCardIndex != null) {
          orderedIndices.remove(selectedCardIndex);
          orderedIndices.insert(0, selectedCardIndex!);
        }

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFD21E6A), // AppColorsLight.pink
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: deliveryLocations.length + 2, // +2 for headers
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // Pickup address header
                      return const Padding(
                        padding: EdgeInsets.only(left: 0, top: 8, bottom: 4),
                        child: Text(
                          'Pickup address',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF535353),
                          ),
                        ),
                      );
                    } else if (index == 1) {
                      // First card (store)
                      final actualIndex = orderedIndices[0];
                      return DeliveryCard(
                        location: deliveryLocations[actualIndex],
                        isSelected: selectedCardIndex == actualIndex,
                        onTap: () => onCardTap(actualIndex),
                      );
                    } else if (index == 2) {
                      // User address header
                      return const Padding(
                        padding: EdgeInsets.only(left: 0, top: 16, bottom: 4),
                        child: Text(
                          'User address',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF535353),
                          ),
                        ),
                      );
                    } else {
                      // Second card (user)
                      final actualIndex = orderedIndices[1];
                      return DeliveryCard(
                        location: deliveryLocations[actualIndex],
                        isSelected: selectedCardIndex == actualIndex,
                        onTap: () => onCardTap(actualIndex),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}