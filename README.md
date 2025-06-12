# 🐘 [PostgreSQL: Views, Índices e Transações](https://github.com/ericfr1tzenvalle/postgresql-view-practice)

Um repositório com exercícios práticos em **PostgreSQL**, focado na criação e manipulação de **views**, no uso estratégico de **índices** para performance e no controle de **transações** para garantir a integridade dos dados.

---

## 🎯 Conteúdo Principal

O projeto está estruturado para cobrir três áreas fundamentais do PostgreSQL:

### 1. Views (`VIEW`)
- 📋 **Listagens Consolidadas:** Criação de views para listar funcionários com seus respectivos departamentos e chefes (auto-relacionamento).
- 📈 **Análise de Dados:** Uma view que calcula o número de compras e o total gasto por cada cliente.
- 🔗 **Domínio de `JOINs`:** Análise comparativa do comportamento de `INNER`, `LEFT`, `RIGHT` e `FULL JOIN` em cenários práticos.

### 2. Índices (`INDEX`)
- ⚡ **Otimização de Buscas:** Criação de um índice na coluna `cpf` da tabela `Funcionario` para acelerar consultas diretas.
- 📅 **Performance em Filtros:** Implementação de um índice na coluna `dataemissao` da tabela `NotaFiscal` para otimizar relatórios e buscas por data.

### 3. Transações (`BEGIN`, `COMMIT`, `ROLLBACK`)
- 🛍️ **Simulação de Venda:** Execução de uma venda complexa como uma transação única, envolvendo a criação da `NotaFiscal` e a inserção dos `ItemVenda`.
- 🛡️ **Garantia de Integridade:** Uso do controle transacional para assegurar que, em caso de erro, nenhuma operação incompleta seja salva no banco (`tudo ou nada`).

---

## 🚀 Como Executar

### Pré-requisitos
- PostgreSQL 13 (ou superior) instalado.
- Um cliente SQL de sua preferência (psql, DBeaver, pgAdmin, etc.).

### Passos
1.  **Clone o repositório:**
    ```bash
    git clone https://github.com/ericfr1tzenvalle/postgresql-view-practice.git
    cd postgresql-view-practice
    ```

2.  **Execute o script:**
    Abra o arquivo `exercises-view-1.sql` no seu cliente SQL e execute todo o conteúdo.

---

## 👤 Autor

**Eric Frizen Valle**

[GitHub: @ericfr1tzenvalle](https://github.com/ericfr1tzenvalle)
