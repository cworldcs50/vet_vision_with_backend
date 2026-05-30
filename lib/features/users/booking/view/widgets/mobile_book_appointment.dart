import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/classes/adaptive_layout.dart';
import '../../../../../core/network/request_status.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../doctors/portal/appointments/data/models/animal_model.dart';
import '../../controller/book_appointment_controller.dart';
import 'custom_checkout_doctor_card.dart';
import 'custom_session_type_selector.dart';
import 'custom_additional_notes.dart';
import 'custom_elevated_btn.dart';

class MobileBookAppointment extends GetView<BookAppointmentController> {
  const MobileBookAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Book Appointment',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: GetBuilder<BookAppointmentController>(
        builder: (ctrl) {
          if (ctrl.currentDoctor == null) {
            return const Center(child: Text("No doctor selected."));
          }
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 16,
              ),
              vertical: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 8,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor Card
                CustomCheckoutDoctorCard(
                  price: ctrl.sessionType == 'online'
                      ? (ctrl.currentDoctor!.consultationFeeOnline ?? 0)
                      : (ctrl.currentDoctor!.consultationFeeOffline ?? 0),
                  specialty: ctrl.currentDoctor!.specialization,
                  doctorName: ctrl.currentDoctor!.name,
                  imgPath: ctrl.currentDoctor!.imageUrl,
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 24,
                  ),
                ),
                // Session Type
                CustomSessionTypeSelector(
                  selectedType: ctrl.sessionType,
                  onChanged: ctrl.onSessionTypeChanged,
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 24,
                  ),
                ),

                // Select Pet
                _buildPetSelector(context, ctrl),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 24,
                  ),
                ),

                // Date & Time
                _buildDateTimeSelector(context, ctrl),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 24,
                  ),
                ),

                // Additional Notes
                CustomAdditionalNotes(controller: ctrl.notesController),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 28,
                  ),
                ),

                // Continue to Payment Button
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedBtn(
                    btnTitle: "Proceed to Payment",
                    onPressed: ctrl.bookingStatus == RequestStatus.loading
                        ? () {}
                        : ctrl.confirmBooking,
                  ),
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPetSelector(
    BuildContext context,
    BookAppointmentController ctrl,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.pets_outlined,
              size: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 18),
              color: AppColors.primaryColor,
            ),
            SizedBox(
              width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 6),
            ),
            Text(
              "Select Your Pet",
              style: TextStyle(
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 16,
                ),
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
        ),
        if (ctrl.animalsStatus == RequestStatus.loading)
          const Center(child: CircularProgressIndicator())
        else if (ctrl.animals.isEmpty)
          const Text("No pets found. Please add a pet in your profile first.")
        else
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(
                AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
              ),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: DropdownButtonFormField<AnimalModel>(
              initialValue: ctrl.selectedAnimal,
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 14,
                  ),
                  vertical: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 12,
                  ),
                ),
                border: InputBorder.none,
              ),
              items: ctrl.animals.map<DropdownMenuItem<AnimalModel>>((animal) {
                return DropdownMenuItem<AnimalModel>(
                  value: animal,
                  child: Text(
                    animal.name,
                    style: TextStyle(
                      fontSize: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 14,
                      ),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (AnimalModel? val) {
                if (val != null) ctrl.onAnimalSelected(val);
              },
            ),
          ),
      ],
    );
  }

  Widget _buildDateTimeSelector(
    BuildContext context,
    BookAppointmentController ctrl,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.calendar_month_outlined,
              size: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 18),
              color: AppColors.primaryColor,
            ),
            SizedBox(
              width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 6),
            ),
            Text(
              "Select Date & Time",
              style: TextStyle(
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 16,
                ),
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
        ),

        if (ctrl.calendarStatus == RequestStatus.loading)
          const Center(child: CircularProgressIndicator())
        else if (ctrl.availableDays.isEmpty)
          const Text("No available dates found.")
        else
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 80),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: ctrl.availableDays.length,
              itemBuilder: (context, index) {
                final dayData = ctrl.availableDays[index];
                final dateStr = dayData['date'].toString();
                final isSelected = ctrl.selectedDate == dateStr;

                // Safely get a 3-letter day name
                String shortDayName = "Day";
                if (dayData['day_name'] != null) {
                  shortDayName = dayData['day_name'].toString().substring(0, 3);
                } else if (dayData['day'] != null) {
                  shortDayName = dayData['day'].toString().substring(0, 3);
                } else {
                  try {
                    final dateObj = DateTime.parse(dateStr);
                    const shortDays = [
                      'Mon',
                      'Tue',
                      'Wed',
                      'Thu',
                      'Fri',
                      'Sat',
                      'Sun',
                    ];
                    shortDayName = shortDays[dateObj.weekday - 1];
                  } catch (_) {}
                }

                return GestureDetector(
                  onTap: () => ctrl.onDateSelected(dateStr),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: EdgeInsets.only(
                      right: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 12,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 16,
                      ),
                      vertical: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 8,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(
                        AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 12,
                        ),
                      ),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primaryColor
                            : Colors.grey.shade200,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          shortDayName,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                            fontSize: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 4,
                          ),
                        ),
                        Text(
                          dateStr.split('-').last,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
        ),

        if (ctrl.selectedDate != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Available Slots",
                style: TextStyle(
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 13,
                  ),
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 8,
                ),
              ),
              if (ctrl.slotsStatus == RequestStatus.loading)
                const Center(child: CircularProgressIndicator())
              else if (ctrl.availableSlots.isEmpty)
                const Text("No available slots for this date.")
              else
                Wrap(
                  spacing: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 10,
                  ),
                  runSpacing: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 8,
                  ),
                  children: ctrl.availableSlots.map((slot) {
                    final isSelected = ctrl.selectedSlot == slot;
                    return GestureDetector(
                      onTap: () => ctrl.onSlotSelected(slot),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: EdgeInsets.symmetric(
                          horizontal: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 14,
                          ),
                          vertical: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 8,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryColor
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(
                            AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 10,
                            ),
                          ),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primaryColor
                                : Colors.grey.shade200,
                          ),
                        ),
                        child: Text(
                          slot,
                          style: TextStyle(
                            fontSize: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 12,
                            ),
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
      ],
    );
  }
}
