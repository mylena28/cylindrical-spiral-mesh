program spire
  use geometry_mod
  implicit none

  integer, parameter :: n_points = 500
  double precision :: points(3, n_points)
  double precision :: radius, height, turns, pi
  integer :: i, unit

  ! Parameters of the spiral
  radius = 1.0d0      ! base radius 
  height = 10.0d0     ! total height
  turns  = 3.0d0      ! number of full rotations
  pi = acos(-1.0d0)

  call generate_spiral(points, n_points, radius, height, turns, pi)

  ! Write to file
  open(newunit=unit, file='spire_points.dat', status='replace', action='write')
  write(unit, *) n_points
  do i = 1, n_points
    write(unit, *) points(1,i), points(2,i), points(3,i)
  end do
  close(unit)

  print *, 'Spiral points written to spire_points.dat'
  print *, 'Number of points:', n_points

end program spire
