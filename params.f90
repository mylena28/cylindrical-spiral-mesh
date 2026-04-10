module params
    implicit none
    integer, parameter :: dp = kind(1.0d0)
    real(dp), parameter :: PI = acos(-1.0_dp)

    ! Helix
    real(dp) :: radius = 1.0_dp
    real(dp) :: height = 10.0_dp
    real(dp) :: turns  = 5.0_dp
    integer  :: n_s = 200

    ! Tube Radius Variation
    real(dp) :: r_base = 0.1_dp  ! Raio no início (s=0)
    real(dp) :: r_tip  = 0.1_dp  ! Raio no fim (s=max)
    integer  :: n_u = 20
end module params
