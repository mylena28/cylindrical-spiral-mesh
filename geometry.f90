module geometry_mod
  implicit none
contains

  subroutine generate_spiral(points, n, radius, height, turns, pi)
    implicit none
    double precision, intent(out) :: points(:,:)   ! points(3, n)
    integer, intent(in) :: n
    double precision, intent(in) :: radius, height, turns, pi

    integer :: i
    double precision :: t, t_max, z, x, y

    t_max = 2.0d0 * pi * turns   ! total angle
    do i = 1, n
      t = (i-1) * t_max / (n-1)                    ! parameter from 0 to t_max
      z = (i-1) * height / (n-1)                   ! height from 0 to height
      x = radius * cos(t)
      y = radius * sin(t)
      points(1,i) = x
      points(2,i) = y
      points(3,i) = z
    end do

  end subroutine generate_spiral

end module geometry_mod
