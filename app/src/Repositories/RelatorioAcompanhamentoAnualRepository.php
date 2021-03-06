<?php

namespace App\Repositories;

use Illuminate\Database\Capsule\Manager as DB;

final class RelatorioAcompanhamentoAnualRepository extends BaseRepository
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
                SUM(DECODE(mes,1,total,0)) mes_1,
                SUM(DECODE(mes,2,total,0)) mes_2,
                SUM(DECODE(mes,3,total,0)) mes_3,
                SUM(DECODE(mes,4,total,0)) mes_4,
                SUM(DECODE(mes,5,total,0)) mes_5,
                SUM(DECODE(mes,6,total,0)) mes_6,
                SUM(DECODE(mes,7,total,0)) mes_7,
                SUM(DECODE(mes,8,total,0)) mes_8,
                SUM(DECODE(mes,9,total,0)) mes_9,
                SUM(DECODE(mes,10,total,0)) mes_10,
                SUM(DECODE(mes,11,total,0)) mes_11,
                SUM(DECODE(mes,12,total,0)) mes_12,
                SUM(total) total_anual
            FROM
                (
                    SELECT
                        ac.descricao categoria,
                        ai.descricao item,
                        TO_CHAR(a.data_cadastro,'MM') mes,
                        CASE WHEN a.data_cadastro IS NOT NULL THEN COUNT(*) ELSE 0 END  total
                    FROM
                        tbl_acompanhamento_categoria ac
                        INNER JOIN tbl_acompanhamento_item ai 
                            ON ai.fk_categoria_acompanhamento = ac.codigo
                        LEFT JOIN tbl_acompanhamento a ON a.fk_acompanhamento = ai.codigo
                            AND a.fk_local = :fk_local
                            AND TO_CHAR(a.data_cadastro,'yyyy') = :ano
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
        $statement->execute();
        $results = $statement->fetchAll();

        $data = [];        
        foreach($results as $key => $value){
            $id = sha1($value['categoria']);
            $data[$id]['descricao'] = $value['categoria'];
            $data[$id]['acompanhamento_item'][] = $value; 
            $data[$id]['totalizadores']['total_anual'] += $value['total_anual'];
            
            for($i = 1; $i <= 12; $i++){
                $mes = 'mes_' . $i;
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
