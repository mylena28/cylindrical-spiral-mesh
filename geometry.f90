module geometry
    use params
    implicit none

contains

    subroutine generate_tube(surf_x, surf_y, surf_z)
        real(dp), dimension(n_s, n_u), intent(out) :: surf_x, surf_y, surf_z
        real(dp) :: t_param, s_frac, u_frac, u_angle
        real(dp), dimension(3) :: vec_P, vec_T, vec_N, vec_B
        real(dp) :: omega, norm_v
        integer :: i, j

        ! Calculation of omega based on your professor's definition
        omega = 2.0_dp * PI * turns / height
        norm_v = sqrt((radius * omega)**2 + 1.0_dp)

        do i = 1, n_s
            s_frac = real(i - 1, dp) / real(n_s - 1, dp)
            t_param = 2.0_dp * PI * turns * s_frac

            ! 1. Center Line Point (x^s)
            vec_P = [radius * cos(t_param), radius * sin(t_param), height * s_frac]

            ! 2. Frenet Vectors
            ! Normal (mu): points toward center of curvature
            vec_N = [-cos(t_param), -sin(t_param), 0.0_dp]

            ! Tangent (helper for Binormal)
            vec_T = [-radius*omega*sin(t_param)/norm_v, &
                      radius*omega*cos(t_param)/norm_v, &
                      1.0_dp/norm_v]

            ! Binormal (beta): T x N
            vec_B(1) = vec_T(2)*vec_N(3) - vec_T(3)*vec_N(2)
            vec_B(2) = vec_T(3)*vec_N(1) - vec_T(1)*vec_N(3)
            vec_B(3) = vec_T(1)*vec_N(2) - vec_T(2)*vec_N(1)

            ! 3. Generate Circle around P
            do j = 1, n_u
                u_frac = real(j - 1, dp) / real(n_u, dp)
                u_angle = 2.0_dp * PI * u_frac

                ! C(s,u) = P + r_tube * (N*cos(u) + B*sin(u))
                surf_x(i,j) = vec_P(1) + r_tube * (vec_N(1)*cos(u_angle) + vec_B(1)*sin(u_angle))
                surf_y(i,j) = vec_P(2) + r_tube * (vec_N(2)*cos(u_angle) + vec_B(2)*sin(u_angle))
                surf_z(i,j) = vec_P(3) + r_tube * (vec_N(3)*cos(u_angle) + vec_B(3)*sin(u_angle))
            end do
        end do
    end subroutine generate_tube

end module geometry
