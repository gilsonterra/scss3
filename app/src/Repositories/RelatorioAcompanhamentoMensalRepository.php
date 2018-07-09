<?php

namespace App\Repositories;

use Illuminate\Database\Capsule\Manager as DB;

final class RelatorioAcompanhamentoMensalRepository extends BaseRepository
{

    /**
     * FetchAll
     *
     * @param array $where
     * @return array
     */
    public function fetchAll(array $where = array())
    {
        $string = "
            SELECT
                categoria,
                item,
                SUM(DECODE(dia,1,total,0)) dia_1,
                SUM(DECODE(dia,2,total,0)) dia_2,
                SUM(DECODE(dia,3,total,0)) dia_3,
                SUM(DECODE(dia,4,total,0)) dia_4,
                SUM(DECODE(dia,5,total,0)) dia_5,
                SUM(DECODE(dia,6,total,0)) dia_6,
                SUM(DECODE(dia,7,total,0)) dia_7,
                SUM(DECODE(dia,8,total,0)) dia_8,
                SUM(DECODE(dia,9,total,0)) dia_9,
                SUM(DECODE(dia,10,total,0)) dia_10,
                SUM(DECODE(dia,11,total,0)) dia_11,
                SUM(DECODE(dia,12,total,0)) dia_12,                
                SUM(DECODE(dia,13,total,0)) dia_13,
                SUM(DECODE(dia,14,total,0)) dia_14,
                SUM(DECODE(dia,15,total,0)) dia_15,
                SUM(DECODE(dia,16,total,0)) dia_16,
                SUM(DECODE(dia,17,total,0)) dia_17,
                SUM(DECODE(dia,18,total,0)) dia_18,
                SUM(DECODE(dia,19,total,0)) dia_19,
                SUM(DECODE(dia,20,total,0)) dia_20,
                SUM(DECODE(dia,21,total,0)) dia_21,
                SUM(DECODE(dia,22,total,0)) dia_22,
                SUM(DECODE(dia,23,total,0)) dia_23,
                SUM(DECODE(dia,24,total,0)) dia_24,
                SUM(DECODE(dia,25,total,0)) dia_25,
                SUM(DECODE(dia,26,total,0)) dia_26,
                SUM(DECODE(dia,27,total,0)) dia_27,
                SUM(DECODE(dia,28,total,0)) dia_28,
                SUM(DECODE(dia,29,total,0)) dia_29,
                SUM(DECODE(dia,30,total,0)) dia_30,
                SUM(DECODE(dia,31,total,0)) dia_31,
                SUM(total) total_anual
            FROM
                (
                    SELECT
                        ac.descricao categoria,
                        ai.descricao item,
                        TO_CHAR(a.data_cadastro,'DD') dia,
                        CASE WHEN a.data_cadastro IS NOT NULL THEN COUNT(*) ELSE 0 END  total
                    FROM
                        tbl_acompanhamento_categoria ac
                        INNER JOIN tbl_acompanhamento_item ai 
                            ON ai.fk_categoria_acompanhamento = ac.codigo
                        LEFT JOIN tbl_acompanhamento a ON a.fk_acompanhamento = ai.codigo
                            AND a.fk_local = :fk_local
                            AND TO_CHAR(a.data_cadastro,'yyyy') = :ano
                            AND TO_CHAR(a.data_cadastro,'MM') = :mes
                            AND a.status = 1
                    GROUP BY
                        ac.descricao,
                        ai.descricao,
                        a.data_cadastro
                )
            GROUP BY
                categoria,
                item
            ORDER BY
                categoria,
                item
            ";


        $pdo = DB::getPdo();
        $statement = $pdo->prepare($string);
        $statement->setFetchMode(\PDO::FETCH_ASSOC);
        $statement->bindParam(':fk_local', $where['fk_local'], \PDO::PARAM_INT);
        $statement->bindParam(':ano', $where['ano'], \PDO::PARAM_INT);
        $statement->bindParam(':mes', $where['mes'], \PDO::PARAM_INT);
        $statement->execute();
        $results = $statement->fetchAll();

        $data = [];        
        foreach($results as $key => $value){
            $id = sha1($value['categoria']);
            $data[$id]['descricao'] = $value['categoria'];
            $data[$id]['acompanhamento_item'][] = $value; 
            $data[$id]['totalizadores']['total_anual'] += $value['total_anual'];
            
            for($i = 1; $i <= 31; $i++){
                $mes = 'dia_' . $i;
                $data[$id]['totalizadores'][$mes] += $value[$mes]; 
            }            
        }

        $dataFormated = [];
        foreach($data as $d){
            $dataFormated[] = $d;
        }

        return $dataFormated;
    }
}
