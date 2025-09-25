sealed class ForgetPasswordEvent {}

class SendForgetRequestEvent extends ForgetPasswordEvent {}

class VerifyCodeEvent extends ForgetPasswordEvent {}

class ResendCodeEvent extends ForgetPasswordEvent {}

class ResetPasswordEvent extends ForgetPasswordEvent {}

class ResendTimerFinishedEvent extends ForgetPasswordEvent {}
