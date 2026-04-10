program main
    use params
    use geometry
    implicit none

    real(dp), allocatable :: surf_x(:,:), surf_y(:,:), surf_z(:,:)
    integer :: i, j, iunit
    integer :: nv, nf, p1, p2, p3, p4

    nv = n_s * n_u
    nf = (n_s - 1) * n_u * 2  ! 2 triangles per quad

    allocate(surf_x(n_s, n_u), surf_y(n_s, n_u), surf_z(n_s, n_u))
    call generate_tube(surf_x, surf_y, surf_z)

    open(newunit=iunit, file='spire_mesh.dat', status='replace')

    ! Header: Number of Vertices, Number of Faces
    write(iunit, *) nv, nf

    ! 1. Write Vertices
    do i = 1, n_s
        do j = 1, n_u
            write(iunit, '(3(F12.6, 1X))') surf_x(i,j), surf_y(i,j), surf_z(i,j)
        end do
    end do

    ! 2. Write Faces (Connectivity)
    do i = 1, n_s - 1
        do j = 1, n_u
            ! Indices of the 4 corners of the quad
            ! Mapping (i,j) to a 1D index
            p1 = (i-1)*n_u + j
            p2 = i*n_u + j

            ! Handle cyclic wrap for u
            if (j < n_u) then
                p3 = i*n_u + (j+1)
                p4 = (i-1)*n_u + (j+1)
            else
                p3 = i*n_u + 1
                p4 = (i-1)*n_u + 1
            end if

            ! Triangle 1: p1 - p2 - p4
            write(iunit, '(3(I8, 1X))') p1, p2, p4
            ! Triangle 2: p2 - p3 - p4
            write(iunit, '(3(I8, 1X))') p2, p3, p4
        end do
    end do

    close(iunit)
    print *, "Mesh generated: spire_mesh.dat"
end program main
