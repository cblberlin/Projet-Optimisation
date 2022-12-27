function M_i = calcul_Mi(m_e, m_u, k)
M_i = zeros(3, 1);

m_s = k .* m_e;
M_f3 = m_u + m_s(3);
M_i(3) = M_f3 + m_e(3);

M_f2 = M_i(3) + m_s(2);
M_i(2) = M_f2 + m_e(2);

M_f1 = M_i(2) + m_s(1);
M_i(1) = M_f1 + m_e(1);

end

