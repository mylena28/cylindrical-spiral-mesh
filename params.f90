module params
    implicit none
    integer, parameter :: dp = kind(1.0d0)
    real(dp), parameter :: PI = acos(-1.0_dp)

    ! Helix
    real(dp) :: radius = 1.0_dp
    real(dp) :: height = 10.0_dp
    real(dp) :: turns  = 5.0_dp
    integer  :: n_s = 200      ! Points along the helix

    ! Tube
    real(dp) :: r_tube = 0.3_dp
    integer  :: n_u = 40       ! Points around the circle
end module params
