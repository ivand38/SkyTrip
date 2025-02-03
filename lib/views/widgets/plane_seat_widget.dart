import 'package:flutter/material.dart';
import 'package:travel_app/cubit/seat_cubit.dart';
import 'package:travel_app/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaneSeatWidget extends StatelessWidget {
  final String id;
  final bool isAvailable;

  const PlaneSeatWidget({
    super.key,
    required this.id,
    this.isAvailable = true,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = context.watch<SeatCubit>().isSelected(id);

    backgroundColor() {
      if (!isAvailable) {
        return strokeColor;
      } else {
        if (isSelected) {
          return primaryColor;
        } else {
          return strokeColor;
        }
      }
    }

    borderColor() {
      if (!isAvailable) {
        return strokeColor;
      } else {
        if (isSelected) {
          return primaryColor;
        } else {
          return primaryColor;
        }
      }
    }

    child() {
      if (isSelected) {
        return Center(
          child: Text(
            'YOU',
            style: whiteTextStyle.copyWith(
              fontSize: 14,
              fontWeight: semiBold,
            ),
          ),
        );
      } else {
        return SizedBox();
      }
    }

    return GestureDetector(
      onTap: () {
        if (isAvailable) {
          context.read<SeatCubit>().selectSeat(id);
        }
      },
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
            color: backgroundColor(),
            border: Border.all(color: borderColor(), width: 2),
            borderRadius: BorderRadius.circular(15)),
        child: child(),
      ),
    );
  }
}
