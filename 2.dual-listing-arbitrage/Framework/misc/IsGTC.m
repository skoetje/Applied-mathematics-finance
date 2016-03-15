function theIsGTC = IsGTC(aOrder)
theIsGTC = strcmpi(aOrder.validity, 'GTC');
