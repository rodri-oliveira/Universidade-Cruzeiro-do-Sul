SELECT last_name, salary
FROM employees
where salary > (SELECT salary FROM employees WHERE last_name = 'Abel');

SELECT last_name, job_id
FROM employees
where job_id = (SELECT job_id FROM employees WHERE employee_id = 141);

SELECT FIRST_NAME, LAST_NAME, JOB_ID
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID
FROM EMPLOYEES
WHERE FIRST_NAME = 'David' and
LAST_NAME = 'Lee')
ORDER BY FIRST_NAME;

SELECT first_name, last_name, job_id, department_id, salary
from employees
where salary > (SELECT AVG(salary) FROM employees)
ORDER BY first_name;

select first_name, last_name, job_id, department_id, salary
from employees
where department_id in (SELECT department_id FROM departments where department_name in ('Marketing', 'Administration'))
ORDER BY first_name;

SELECT e.first_name, e.last_name, e.job_id, e.department_id, e.salary, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.department_id IN (SELECT department_id FROM departments WHERE department_name IN ('Marketing', 'Administration'))
ORDER BY e.first_name;

select e.last_name, e.first_name, e.job_id, e.department_id, e.salary
from employees e
where salary > (select max(e2.salary) 
                from employees e2 where e2.department_id = (select d.department_id from departments d
                where d.department_name = 'Sales'))
                ORDER BY e.first_name;


select employee_id, last_name,job_id, salary
from employees
where salary > ANY (select salary from employees where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';

select employee_id, last_name,job_id, salary
from employees
where salary > ALL (select salary from employees where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';


SELECT employee_id, manager_id, first_name, last_name, job_id, department_id, salary
FROM employees e
WHERE EXISTS 
(SELECT e.employee_id FROM employees WHERE e.manager_id = employees.employee_id)
ORDER BY e.employee_id;


select first_name, job_id,
decode (job_id, 'it_prog', 'programador',
        'fi_account', 'contador',
        'indefinido')decode_cargo from employees;
        
select first_name, job_id, salary AS "Salario Atual",
decode (job_id, 
        'it_prog', salary * 1.1,
        'fi_account', salary * 1.2,
            salary * 1.05) AS Salario_Reajustado from employees;
            
select first_name, job_id, salary,
    CASE
        when salary < 2000 then salary * 1.10
        when salary > 5000 then salary * 0.90
        else salary
    end as classificação
from employees 
ORDER BY salary desc;

SELECT EMPLOYEE_ID, MANAGER_ID, FIRST_NAME, LAST_NAME,
JOB_ID, DEPARTMENT_ID, SALARY
FROM EMPLOYEES E
WHERE NOT EXISTS (SELECT EMPLOYEE_ID
FROM EMPLOYEES
WHERE EMPLOYEES.MANAGER_ID = E. EMPLOYEE_ID)
ORDER BY EMPLOYEE_ID;

--funções de grupo

--Retorna a média aritmética de um grupo de registros. Por exemplo, para calcular
--a média salarial dos empregados, faça:

SELECT CONCAT('R$ ', round(AVG(SALARY), 2)) AS Média_Salarial from employees;

--Retorna o menor, maior e a somatória dos valores de um grupo de registros.
select min(salary) as "menor salario", max(salary)as "maior salário", sum(salary) as "soma salarios"
from employees
where department_id = 30;

/*Retorna a quantidade de registros de um grupo de registros. Por exemplo, para
encontrar o número de empregados do Departamento 30, faça:*/
select count(*)
from employees
where department_id = 30;

/*Com o uso do GROUP BY é possível agruparmos diversos registros com base
em uma ou mais colunas de uma tabela*/

select department_id
from employees
GROUP BY department_id;

select department_id, round(avg(salary),2)
from employees
GROUP BY department_id;

select round(avg(salary), 2)
from employees
GROUP BY department_id;

select round(avg(salary), 2), count(*)
from employees
GROUP BY department_id
ORDER BY count(*) DESC;

select department_id dept_id, job_id, round(avg(salary),2), sum(salary)
from employees
GROUP BY department_id, job_id
ORDER BY department_id;

select department_id, round(avg(salary), 2)
from employees
where department_id not in (10,20,30)
GROUP BY department_id, job_id
ORDER BY department_id;

select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000;

select department_id, max(salary)
from employees
where department_id is not null
group by department_id
having avg(salary) > 5000
ORDER BY department_id;

select department_id, max(salary)
from employees
where department_id in (10,20,30,40)
GROUP BY department_id
having max(salary) > 10000
order by department_id;

















