class AppLink {
  // ─── Base URL ────────────────────────────────────────────────────────────────
  static const String server = String.fromEnvironment(
    "API_BASE_URL",
    defaultValue: "http://10.0.2.2:8000/api",
  ); // Set API_BASE_URL for your Laravel host machine.

  // ─── AUTH ────────────────────────────────────────────────────────────────────
  static const String login = "$server/login";
  static const String signUp = "$server/register";
  static const String verifyEmail = "$server/verify-email";
  static const String resetPassword = "$server/reset-password";
  static const String updateProfile = "$server/update-profile";
  static const String forgetPassword = "$server/forgot-password";
  static const String logout = "$server/logout";
  static const String socialLogin = "$server/auth/social-token-login";
  static const String authWithGoogle = "$server/auth/google/redirect";
  static const String authWithFacebook = "$server/auth/facebook/redirect";

  // ─── DOCTORS ────────────────────────────────────────────────────────────────
  static const String doctors = "$server/doctors";
  static const String specialization = "$server/doctors/specializations";
  static const String nearestDoctors = "$server/doctors/nearest";
  static const String nearbyDoctors = "$server/doctors/nearby";

  static String doctor(String id) => "$server/doctors/$id";
  static String doctorReviewsList(String id) => "$server/doctors/$id/reviews";
  static String availableSlots(String doctorId) =>
      "$server/doctors/$doctorId/available-slots";
  static String availabilityCalendar(String id) =>
      "$server/doctors/$id/availability-calendar";

  // ─── DOCTOR PROFILE (doctor role only) ──────────────────────────────────────
  static const String doctorVerify = "$server/doctor/verify";
  static const String doctorMyReviews = "$server/doctor/reviews";
  static const String doctorDashboard = "$server/doctor/dashboard";
  static const String doctorAnalytics = "$server/doctor/analytics";
  static const String setAvailability = "$server/doctor/availability";
  static const String doctorAppointments = "$server/doctor/appointments";
  static const String completeProfile = "$server/doctor/complete-profile";
  static const String doctorProfile       = "$server/doctor/profile";
  static const String doctorUpdateProfile = "$server/doctor/update-profile";

  // ─── USER DASHBOARD ─────────────────────────────────────────────────────────
  static const String userDashboard = "$server/user/dashboard";

  // ─── ANIMALS ─────────────────────────────────────────────────────────────────
  static const String myAnimals = "$server/my-animals";
  static const String animals = "$server/animals";

  static String animal(String id) => "$server/animals/$id";
  static String animalUpdate(String id) => "$server/animals/update/$id";

  // ─── APPOINTMENTS ────────────────────────────────────────────────────────────
  static const String appointments = "$server/appointments";
  static const String myAppointments = "$server/my-appointments";
  static const String checkAvailability =
      "$server/appointments/check-availability";

  static String appointment(String id) => "$server/appointments/$id";
  static String cancelAppointment(String id) =>
      "$server/appointments/$id/cancel";
  static String rescheduleAppointment(String id) =>
      "$server/appointments/$id/reschedule";
  static String updateAppointmentStatus(String id) =>
      "$server/appointments/$id/status";
  static String rateAppointment(String id) => "$server/appointments/$id/rate";

  // ─── DIAGNOSIS ───────────────────────────────────────────────────────────────
  static String diagnose(String animalId) => "$server/diagnose/$animalId";
  static String diagnosis(String id) => "$server/diagnosis/$id";
  static String animalDiagnoses(String animalId) =>
      "$server/animals/$animalId/diagnoses";

  // ─── MEDICAL RECORDS ─────────────────────────────────────────────────────────
  static String animalPrescriptions(String id) =>
      "$server/animals/$id/prescriptions";
  static String medicalHistory(String id) =>
      "$server/animals/$id/medical-history";
  static String markPrescriptionComplete(String id) =>
      "$server/prescriptions/$id/mark-complete";
  static String discontinuePrescription(String id) =>
      "$server/prescriptions/$id/discontinue";
  static String storePrescription(String appointmentId) =>
      "$server/appointments/$appointmentId/prescription";
  static String storeTreatmentRecord(String appointmentId) =>
      "$server/appointments/$appointmentId/treatment-record";

  // ─── REVIEWS ─────────────────────────────────────────────────────────────────
  static String storeReview(String appointmentId) =>
      "$server/appointments/$appointmentId/rate";
  static String review(String id) => "$server/reviews/$id";

  // ─── CHAT ────────────────────────────────────────────────────────────────────
  static const String chatSessions = "$server/chat/sessions";
  static String chatStart(String doctorId) => "$server/chat/start/$doctorId";
  static String chatSend(String sessionId) => "$server/chat/$sessionId/send";
  static String chatMessages(String sessionId) =>
      "$server/chat/$sessionId/messages";

  // ─── PAYMENT ─────────────────────────────────────────────────────────────────
  static String pay(String appointmentId) =>
      "$server/payments/$appointmentId/pay";
  static String paymentStatus(String appointmentId) =>
      "$server/payments/$appointmentId/status";

  // ─── NOTIFICATIONS ───────────────────────────────────────────────────────────
  static const String notifications = "$server/notifications";
  static const String unreadNotifications = "$server/notifications/unread";
  static const String notificationBadge = "$server/notifications/badge";
  static const String readAllNotifications = "$server/notifications/read-all";

  static String notification(String id) => "$server/notifications/$id";
}
