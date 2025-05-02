import { Condition, ProjectView } from "../types";

type getConditionRulesReturn = {
    value: string | boolean | undefined, 
    required: boolean | undefined
}

export const getConditionRules = (id: number, conditions: Condition[], project: ProjectView) : getConditionRulesReturn => {
    const conditionResponse: getConditionRulesReturn= { value: undefined, required: undefined }

    const existsCondition = project?.lease_request?.conditions.find(c => c.condition_id === id)
    if(existsCondition) {
        conditionResponse.value = existsCondition.value
    } else {
        // There any rule
        conditionResponse.value = rules(id, conditions, project)
    }

    return conditionResponse
}

const rules = (id: number, conditions: Condition[], project: ProjectView) : string | undefined => {
    let value : string | undefined = undefined
    
    switch(id) {
        case 2:
            // Renta Mensual
            const price = project.lands.reduce((total, land) => total + (land.area * land.land.price_per_area), 0)
            value = price.toString()
            break;
        case 4:
            const pricePerArea = project.lands.reduce((total, land) => total + land.land.price_per_area, 0)
            value = pricePerArea.toString()
            break;
    }

    return value
}